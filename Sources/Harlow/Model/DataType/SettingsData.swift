//
//  SettingsData.swift
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
import SourceModel

class SettingsData: ModelCollection {
    
    var numberOfItems: Int {
        return sections[0].numberOfItems
    }
    
    var sections: [Section]
    
    init(isDataPersistenceEnabled: Bool) {
        if isDataPersistenceEnabled {
            sections = [
                Section(withType: .information),
                Section(withType: .animation),
                Section(withType: .data),
                Section(withType: .settings)
            ]
        } else {
            sections = [
                Section(withType: .information),
                Section(withType: .animation),
            ]
        }
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    subscript(indexPath: IndexPath) -> Model? {
        return sections[indexPath.section].settings[indexPath.row]
    }
    
    subscript(section: Int) -> ModelCollection {
        return sections[section]
    }
    
    func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return SettingsCell.self
    }
    
    class Section: ModelCollection {
        
        init(withType sectionType: SectionType) {
            self.sectionType = sectionType
            
            switch sectionType {
            case .information: settings = [Setting(type: .version), Setting(type: .device)]
            case .data: settings = [Setting(type: .storeAnalytics), Setting(type: .storeLogs), Setting(type: .storeNetworking), Setting(type: .storeError), Setting(type: .storeCrashes)]
            case .settings: settings = [Setting(type: .resetAll), Setting(type: .removeData), Setting(type: .removeAnalytics), Setting(type: .removeNetworking), Setting(type: .removeLogs), Setting(type: .removeError), Setting(type: .removeCrashes)]
            case .animation: settings = [Setting(type: .bubblePulse), Setting(type: .debuggerIcons)]
            }
        }
        
        var sectionType: SectionType
        var settings: [Setting]
        
        var numberOfItems: Int {
            return settings.count
        }
        
        var numberOfSections: Int { return 1 }
        
        subscript(indexPath: IndexPath) -> Model? {
            return settings[indexPath.row]
        }
        
        subscript(section: Int) -> ModelCollection {
            return self
        }
        
        var title: String {
            switch sectionType {
            case .data: return "Data"
            case .information: return "App Information"
            case .settings: return "Settings"
            case .animation: return "Animation"
            }
        }
        
        enum SectionType {
            case information, data, settings, animation
        }
        
        enum SettingType: String {
            case device, version, storeAnalytics, storeError, storeNetworking, storeLogs, resetAll, removeData, removeAnalytics, bubblePulse, debuggerIcons, removeError, removeNetworking, removeLogs, removeCrashes, storeCrashes
        }
        
        struct Setting: Model {
            var type: SettingType
            var id: String?
            
            var isOn: Bool {
                switch type {
                case .device, .version, .resetAll, .removeData, .removeAnalytics, .removeLogs, .removeError, .removeNetworking, .removeCrashes: return false
                case .storeLogs: return DebuggerSettings.shouldStoreLogsData
                case .storeError: return DebuggerSettings.shouldStoreErrorData
                case .storeNetworking: return DebuggerSettings.shouldStoreNetworkingData
                case .storeAnalytics: return DebuggerSettings.shouldStoreAnalyticsData
                case .bubblePulse: return DebuggerSettings.isDebuggerBubblePulseAnimationEnabled
                case .debuggerIcons: return DebuggerSettings.isDebuggerItemIconsAnimationEnabled
                case .storeCrashes: return DebuggerSettings.shouldStoreCrashesData
                }
            }
            
            var isSeparatorVisible: Bool = true
            var isActionable: Bool {
                switch type {
                case .device, .version, .storeAnalytics, .bubblePulse, .debuggerIcons, .storeNetworking, .storeError, .storeLogs, .storeCrashes: return false
                case .resetAll, .removeData, .removeAnalytics, .removeNetworking, .removeError, .removeLogs, .removeCrashes: return true
                }
            }
            
            var hasSwitch: Bool {
                switch type {
                case .device, .version, .resetAll, .removeData, .removeAnalytics, .removeNetworking, .removeError, .removeLogs, .removeCrashes: return false
                case .storeAnalytics, .storeNetworking, .storeError, .storeLogs, .bubblePulse, .debuggerIcons, .storeCrashes: return true
                }
            }
            
            var title: String? {
                
                let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                switch type {
                case .device: return "Device: unknown"
                case .version: return "Version: \(version) (\(build))"
                case .storeAnalytics: return "Save Analytics Information"
                case .storeNetworking: return "Save Networking Information"
                case .storeError: return "Save NSError Information"
                case .storeLogs: return "Save Log Information"
                case .storeCrashes: return "Save Crash Information"
                case .resetAll: return "Restore to Default Settings"
                case .removeData: return "Delete Cached Data"
                case .removeAnalytics: return "Delete Analytics Data"
                case .removeNetworking: return "Delete Networking Data"
                case .removeError: return "Delete Error Data"
                case .removeLogs: return "Delete Logs Data"
                case .removeCrashes: return "Delete Crashes Data"
                case .bubblePulse: return "Enable Bubble Pulse Animation"
                case .debuggerIcons: return "Enable Bubble Emoji Animation"
                }
            }
            
            init(type: SettingType) {
                self.type = type
            }
        }
        
        func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
            return nil
        }
    }
}
