//
//  SettingsActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation

protocol SettingsActionable {
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType)
    func didTap(action: SettingsData.Section.SettingType)
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
        case .bubblePulse:
            DebuggerSettings.isDebuggerBubblePulseAnimationEnabled = value
        case .debuggerIcons:
            DebuggerSettings.isDebuggerItemIconsAnimationEnabled = value
        default: break
        }
    }
    
    func didTap(action: SettingsData.Section.SettingType) {
        switch action {
        case .removeAnalytics:
            coordinator?.shouldReset(.analytics) { [unowned self] in
                self.appData.analyticsItems.removeAll()
                self.appData.save()
            }
        case .removeData:
            coordinator?.shouldReset(.allData) { [unowned self] in
                self.appData.removeAll()
                self.appData.save()
            }
        case .resetAll:
            coordinator?.shouldReset(.settings) {
                DebuggerSettings.restoreDefaults()
            }
        default: break
        }
    }
}
