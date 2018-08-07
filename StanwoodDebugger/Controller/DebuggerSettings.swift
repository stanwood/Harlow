//
//  DebuggerSettings.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation

class DebuggerSettings {
    
    private enum LocalKeys: String {
        case shouldStoreAnalyticsData,
        isDebuggerBubblePulseAnimationEnabled,
        isDebuggerItemIconsAnimationEnabled
        
        var key: String {
            switch self {
            case .shouldStoreAnalyticsData:
                return "should_store_analytics_data"
            case .isDebuggerBubblePulseAnimationEnabled:
                return "is_debugger_bubble_pulse_animation_enabled"
            case .isDebuggerItemIconsAnimationEnabled:
                return "is_debugger_item_icons_animation_enabled"
            }
        }
    }
    
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
            return defaults.bool(forKey: LocalKeys.shouldStoreAnalyticsData.key)
        }
        
        set {
            defaults.set(newValue, forKey: LocalKeys.shouldStoreAnalyticsData.key)
        }
    }
    
    static var isDebuggerBubblePulseAnimationEnabled: Bool {
        get {
            return defaults.bool(forKey: LocalKeys.isDebuggerBubblePulseAnimationEnabled.key)
        }
        
        set {
            defaults.set(newValue, forKey: LocalKeys.isDebuggerBubblePulseAnimationEnabled.key)
        }
    }
    
    static var isDebuggerItemIconsAnimationEnabled: Bool {
        get {
            return defaults.bool(forKey: LocalKeys.isDebuggerItemIconsAnimationEnabled.key)
        }
        
        set {
            defaults.set(newValue, forKey: LocalKeys.isDebuggerItemIconsAnimationEnabled.key)
        }
    }
    
    static func restoreDefaults() {
        /// Handle: Low prio later feature
    }
}
