//
//  DebuggerNSError.swift
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
import UIKit

extension NSError {
    
    @objc class func errorSwizzle() {
        guard let instance = class_getInstanceMethod(self, #selector(NSError.init(domain:code:userInfo:))),
            let swizzleInstance = class_getInstanceMethod(self, #selector(NSError.init(swizzleDomain:code:info:))) else { return }
        method_exchangeImplementations(instance, swizzleInstance)
    }
    
    @objc class func errorUnSwizzle() {
        guard let instance = class_getInstanceMethod(self, #selector(NSError.init(domain:code:userInfo:))),
            let swizzleInstance = class_getInstanceMethod(self, #selector(NSError.init(swizzleDomain:code:info:))) else { return }
        method_exchangeImplementations(swizzleInstance, instance)
    }
    
    @objc convenience init(swizzleDomain: String, code: Int, info: [String : Any]?) {
        self.init(swizzleDomain: swizzleDomain, code: code, info: info)
        
        /// Checking for error code exceptions
        if !DebuggerNSError.errorCodesExceptions.contains(code) {
            let errorItem = ErrorItem(error: self)
            NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidReceiveErrorItem, object: errorItem)
        }
    }
}

class DebuggerNSError {
    
    static var errorCodesExceptions: [Int] = []
    static var isEnabled: Bool = true {
        didSet {
            switch isEnabled {
            case true:
                DebuggerNSError.register()
            case false:
                DebuggerNSError.unregister()
            }
        }
    }
    
    class func register() {
        NSError.errorSwizzle()
    }
    
    class func unregister() {
        NSError.errorUnSwizzle()
    }
}
