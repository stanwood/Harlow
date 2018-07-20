//
//  Notification+Name+Extension.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
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
    
    public static var DeuggerDidReceiveUITestingItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didReceiveUITestingItem")
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
    
    static var DeuggerDidAppendErrorItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendErrorItem")
    }
    
    static var DeuggerDidAppendUITestingItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendUITestingItem")
    }
    
    static var DeuggerDidAppendNetworkingItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendNetworkingItem")
    }
    
    static var DeuggerDidAppendLogItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAppendLogItem")
    }
    
    static var DeuggerDidAddDebuggerItem: Notification.Name {
        return NSNotification.Name(rawValue: "io.stanwood.debugger.didAddDebuggerItem")
    }
}
