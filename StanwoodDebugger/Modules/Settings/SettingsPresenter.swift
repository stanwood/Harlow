//
//  SettingsPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation
import StanwoodCore

protocol SettingsViewable: class {
    
}

class SettingsPresenter: Presentable, SourceTypePresentable {
    
    typealias DataSource = SettingsDataSource
    typealias Delegate = SettingsDelegate
    typealias Actionable = SettingsActionable
    typealias Parameterable = SettingsParameterable
    typealias Viewable = SettingsViewable
    
    var dataSource: SettingsDataSource!
    var delegate: SettingsDelegate!
    var actionable: SettingsActionable
    var parameterable: SettingsParameterable
    weak var viewable: SettingsViewable?
    
    private var settingsData = SettingsData()
    
    required init(actionable: SettingsActionable, parameterable: SettingsParameterable, viewable: SettingsViewable) {
        self.actionable = actionable
        self.parameterable = parameterable
        self.viewable = viewable
        
        dataSource = SettingsDataSource(dataType: settingsData)
        delegate = SettingsDelegate(dataType: settingsData)
        
        dataSource.presenter = self
        delegate.presenter = self
    }
    
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType) {
        actionable.switchDidChange(to: value, for: type)
    }
    
    func didTapAction(_ type: SettingsData.Section.SettingType) {
        actionable.didTap(action: type)
    }
}
