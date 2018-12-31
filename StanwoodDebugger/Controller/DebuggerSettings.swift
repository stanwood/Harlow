//
//  DebuggerSettings.swift
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

class DebuggerSettings {
    
    private static var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    private static func getDefaultSettings() ->  [String: Any] {
        let bundle = Bundle.debuggerBundle(from: type(of: DebuggerSettings()))
        if let path = bundle.path(forResource: "DefaultSettings", ofType: "plist"), let parameters = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> {
            return parameters
        } else {
            fatalError("Settings plist file is missing!")
        }
    }
    
    static func setDefaultSettings() {
        UserDefaults.standard.register(defaults: getDefaultSettings())
    }
    
    static var shouldStoreAnalyticsData: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var shouldStoreErrorData: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var shouldStoreNetowrkingData: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var shouldStoreLogsData: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var isDebuggerBubblePulseAnimationEnabled: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var isDebuggerItemIconsAnimationEnabled: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static func restoreDefaults() {
        shouldStoreNetowrkingData = true
        shouldStoreErrorData = true
        isDebuggerItemIconsAnimationEnabled = true
        isDebuggerBubblePulseAnimationEnabled = true
        shouldStoreAnalyticsData = true
        shouldStoreLogsData = true
    }
}
