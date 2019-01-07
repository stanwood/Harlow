//
//  GroupOperations.swift
//
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

@objc protocol OperationQueueDelegate: NSObjectProtocol {
    @objc optional func operationDidFinish(withError error: String, operation: Operation)
    @objc optional func operationDidFinish(withMessage message: String, operation: Operation)
}

typealias FailureBlock = Optional<((_ error: String?) -> Void)>

class GroupOperation: Operation, OperationQueueDelegate {
    
    fileprivate let internalQueue = OperationQueue()
    var failureBlock: FailureBlock
    
    var errorMessage: String?
    private var infoMessages: [String]?
    
    lazy var userInfo:[AnyHashable: Any]? = [:]
    
    required init(name: String? = "") {
        super.init()
        self.name = name
    }
    
    override init() {
        super.init()
        internalQueue.isSuspended = true
        internalQueue.maxConcurrentOperationCount = 1
    }
    
    deinit {
        cancel()
    }
    
    override func cancel() {
        internalQueue.cancelAllOperations()
        super.cancel()
    }
    
    func execute() {
        internalQueue.isSuspended = false
    }
    
    func add(operation: Operation) {
        internalQueue.addOperation(operation)
    }
    
    func add(operations: [Operation]) {
        internalQueue.isSuspended = true
        
        for operation in operations {
            internalQueue.addOperation(operation)
        }
    }
    
    func didFinishedWithFailure() {
        if let failureBlock = failureBlock {
            DispatchQueue.main.async(execute: {
                failureBlock(self.errorMessage)
            })
        }
    }
    
    func getOperation(forKey key: String) -> Operation? {
        for operation in internalQueue.operations {
            guard !operation.isFinished else { continue }
            
            if let _name = operation.name {
                if _name == key {
                    return operation
                }
            }
        }
        
        return nil
    }
    
    func doesContain(_ operation: Operation) -> Bool {
        return internalQueue.operations.contains(operation)
    }
}

extension GroupOperation {
    
    func operationDidFinish(operation: Operation, withError error: String) {
        self.errorMessage = error
        
        internalQueue.isSuspended = true
        internalQueue.cancelAllOperations()
        
        didFinishedWithFailure()
    }
}
