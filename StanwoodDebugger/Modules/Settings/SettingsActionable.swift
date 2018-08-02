//
//  SettingsActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation

protocol SettingsActionable {
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType)
}

extension DebuggerActions: SettingsActionable {
    
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType) {
        switch type {
        case .storeAnalytics where value:
            DebuggerSettings.shouldStoreAnalyticsData = value
        case .storeAnalytics where !value:
            appData.analyticsItems.removeAll()
            appData.save()
            DebuggerSettings.shouldStoreAnalyticsData = value
        default: break
        }
    }
}
