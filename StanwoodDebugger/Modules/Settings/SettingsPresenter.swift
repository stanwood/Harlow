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
