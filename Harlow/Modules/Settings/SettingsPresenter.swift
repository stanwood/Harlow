//
//  SettingsPresenter.swift
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
import StanwoodCore

protocol SettingsViewable: class {
    
}

class SettingsPresenter: Presentable {
    
    typealias DataSource = SettingsDataSource
    typealias Delegate = SettingsDelegate
    typealias Actionable = SettingsActionable
    typealias Parameterable = SettingsParameterable
    typealias Viewable = SettingsViewable
    
    var dataSource: SettingsDataSource!
    var delegate: SettingsDelegate!
    var actions: SettingsActionable
    var parameters: SettingsParameterable
    weak var view: SettingsViewable?
    
    private var settingsData = SettingsData()
    
    required init(actions: SettingsActionable, parameters: SettingsParameterable, view: SettingsViewable) {
        self.actions = actions
        self.parameters = parameters
        self.view = view
        
        dataSource = SettingsDataSource(modelCollection: settingsData)
        delegate = SettingsDelegate(modelCollection: settingsData)

        dataSource.presenter = self
        delegate.presenter = self
    }
    
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType) {
        actions.switchDidChange(to: value, for: type)
    }
    
    func didTapAction(_ type: SettingsData.Section.SettingType) {
        actions.didTap(action: type)
    }
}
