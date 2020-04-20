//
//  DebuggerNetworking.swift
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import Foundation

extension NSMutableURLRequest {
    
    @objc class func httpSwizzle() {
        guard let httpCall = class_getInstanceMethod(self, #selector(setter: NSMutableURLRequest.httpBody)),
            let httpSwizzleCall = class_getInstanceMethod(self, #selector(httpHack(body:))) else { return }
        
        method_exchangeImplementations(httpCall, httpSwizzleCall)
    }
    
    @objc func httpHack(body: NSData?) {
        defer {
            httpHack(body: body)
        }
        
        let key = "\(hashValue)"
        guard let body = body, bodyDictionary[key] == nil else { return }
        bodyDictionary[key] = body as Data
    }
}

fileprivate var bodyDictionary: [String: Data] = [:]

class DebuggerNetworking: URLProtocol {
    
    lazy var networkQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "io.stanwood.debugger.networking"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    private var sessionTask: URLSessionTask?
    private var response: URLResponse?
    private var newRequest: NSMutableURLRequest?
    private var session: URLSession?
    
    private var connection: NSURLConnection?
    private var responseData: NSMutableData?
    private var networkItem: NetworkItem?
    
    static var isEnabled: Bool = true {
        didSet {
            switch isEnabled {
            case true:
                DebuggerNetworking.register()
            case false:
                DebuggerNetworking.unregister()
            }
        }
    }
    
    class func register(custom configuration: URLSessionConfiguration) {
        configuration.protocolClasses?.insert(DebuggerNetworking.self, at: 0)
    }
    
    class func register() {
        NSMutableURLRequest.httpSwizzle()
        URLProtocol.registerClass(DebuggerNetworking.classForCoder())
    }
    
    class func unregister() {
        URLProtocol.unregisterClass(DebuggerNetworking.classForCoder())
    }
    
    open override class func canInit(with request: URLRequest) -> Bool {
        if !isEnabled || property(forKey: "ProtocolHandledKey", in: request) != nil {
            return false
        }
        return true
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    open override class func requestIsCacheEquivalent(_ reqA: URLRequest, to reqB: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(reqA, to: reqB)
    }
    
    override func startLoading() {
        guard let request = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest,
            self.newRequest == nil else {
                return
        }
        
        /// Setting the property to keep track of the request
        DebuggerNetworking.setProperty(true, forKey: "ProtocolHandledKey", in: request)
        
        self.newRequest = request
        session = URLSession(configuration: .default, delegate: self, delegateQueue: networkQueue)
        sessionTask = session?.dataTask(with: request as URLRequest)
        sessionTask?.resume()
        
        responseData = NSMutableData()
        networkItem = NetworkItem(request: request as URLRequest)
    }
    
    override func stopLoading() {
        sessionTask?.cancel()
        guard var networkItem = networkItem else {return}
        
        if let data = (newRequest as URLRequest?)?.body {
            networkItem.httpBody = data
        }
        
        let duration = fabs(networkItem.requestDate.timeIntervalSinceNow)
        networkItem.duration = duration
        
        NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidReceiveNetworkingItem, object: networkItem)
    }
}

extension DebuggerNetworking: URLSessionDataDelegate, URLSessionTaskDelegate {
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        completionHandler(.allow)
        
        networkItem?.set(response: response)
        if let data = responseData {
            networkItem?.dataResponse = data as Data
        }
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
        responseData?.append(data)
        
        if let data = responseData {
            networkItem?.dataResponse = data as Data
        }
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
            let errorMessage = error.localizedDescription
            networkItem?.errorDescription = errorMessage
            return
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let error = error {
            let errorMessage = error.localizedDescription
            networkItem?.errorDescription = errorMessage
            return
        }
    }
}
