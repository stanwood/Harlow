//
//  DebuggerSettings.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation

class DebuggerSettings {
    
    private enum LocalKeys: String {
        case shouldStoreAnalyticsData
        
        var key: String {
            switch self {
            case .shouldStoreAnalyticsData:
                return "should_store_analytics_data"
            }
        }
    }
    
    private static var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    private static func getDefaultSettings() ->  [String: Any] {
        if let path = Bundle.debuggerBundle().path(forResource: "DefaultSettings", ofType: "plist"), let parameters = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> {
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
}
