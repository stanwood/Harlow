//
//  SettingsActionable.swift
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
        case .storeLogs where value:
            DebuggerSettings.shouldStoreLogsData = value
        case .storeLogs where !value:
            appData.logItems.removeAll()
            appData.save()
            DebuggerSettings.shouldStoreLogsData = value
        case .storeNetworking where value:
            DebuggerSettings.shouldStoreNetworkingData = value
        case .storeNetworking where !value:
            appData.networkingItems.removeAll()
            appData.save()
            DebuggerSettings.shouldStoreNetworkingData = value
        case .storeCrashes where value:
            DebuggerSettings.shouldStoreCrashesData = value
        case .storeCrashes where !value:
            appData.crashItems.removeAll()
            appData.save()
            DebuggerSettings.shouldStoreCrashesData = value
        case .storeError where value:
            DebuggerSettings.shouldStoreErrorData = value
        case .storeError where !value:
            appData.errorItems.removeAll()
            appData.save()
            DebuggerSettings.shouldStoreErrorData = value
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
                self.appData.store(type: .analytics)
                self.appData.refresh()
            }
        case .removeData:
            coordinator?.shouldReset(.allData) { [unowned self] in
                self.appData.removeAll()
                self.appData.save()
                self.appData.refresh()
            }
        case .resetAll:
            coordinator?.shouldReset(.settings) {
                DebuggerSettings.restoreDefaults()
            }
        case .removeError:
            coordinator?.shouldReset(.errors) { [unowned self] in
                self.appData.errorItems.removeAll()
                self.appData.store(type: .error)
                self.appData.refresh()
            }
        case .removeLogs:
            coordinator?.shouldReset(.logs) { [unowned self] in
                self.appData.logItems.removeAll()
                self.appData.store(type: .logs)
                self.appData.refresh()
            }
        case .removeNetworking:
            coordinator?.shouldReset(.networking) { [unowned self] in
                self.appData.networkingItems.removeAll()
                self.appData.store(type: .networking)
                self.appData.refresh()
            }
        case .removeCrashes:
            coordinator?.shouldReset(.crashes) { [unowned self] in
                self.appData.crashItems.removeAll()
                self.appData.store(type: .crashes)
                self.appData.refresh()
            }
        default: break
        }
    }
}
