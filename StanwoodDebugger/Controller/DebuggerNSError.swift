//
//  DebuggerNSError.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import Foundation

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
