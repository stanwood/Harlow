//
//  Notification+Name+Extension.swift
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

extension Notification.Name {
    
    // MARK: - Did Receive
    
    public static var DebuggerDidReceiveAnalyticsItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didReceiveAnalyticsItem")
    }
    
    public static var DeuggerDidReceiveErrorItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didReceiveErrorItem")
    }
    
    public static var DeuggerDidReceiveCrashItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didReceiveCrashItem")
    }
    
    public static var DeuggerDidReceiveNetworkingItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didReceiveNetworkingItem")
    }
    
    public static var DeuggerDidReceiveLogItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didReceiveLogItem")
    }
    
    // MARK: - Did Append
    
    static var DebuggerDidAppendAnalyticsItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendAnalyticsItem")
    }
    
    static var DebuggerDidAppendErrorItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendErrorItem")
    }
    
    static var DebuggerDidAppendCrashItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendCrashItem")
    }
    
    static var DebuggerDidAppendNetworkingItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendNetworkingItem")
    }
    
    static var DebuggerDidAppendLogItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendLogItem")
    }
    
    static var DebuggerDidAddDebuggerItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAddDebuggerItem")
    }
}
