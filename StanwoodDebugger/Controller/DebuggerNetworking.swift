//
//  DebuggerNetworking.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/12/2018.
//

import Foundation

extension NSMutableURLRequest {
    
    @objc class func httpSwizzle() {
        guard let httpCall = class_getInstanceMethod(self, #selector(setter: NSMutableURLRequest.httpBody)),
            let httpSwizzleCall = class_getInstanceMethod(self, #selector(httpHack(body:))) else { return }
        
        method_exchangeImplementations(httpCall, httpSwizzleCall)
    }
    
    @objc func httpHack(body: NSData?) {
        let key = "\(hashValue)"
        guard let body = body, bodyDictionary[key] == nil else { return }
        bodyDictionary[key] = body as Data
    }
}

fileprivate var bodyDictionary: [String: Data] = [:]

class DebuggerNetworking: URLProtocol {
    
    lazy var queue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "io.stanwood.debugger.networking"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    
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
        
    }
    
    override func stopLoading() {
        
    }
}
