//
//  SettingsCell.swift
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

import UIKit
import SourceModel
import StanwoodCore

protocol SettingsCellDelegate: class {
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType)
    func didTapAction(_ type: SettingsData.Section.SettingType)
}

class SettingsCell: Stanwood.AutoSizeableCell, Fillable {

    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var switchButton: UISwitch!
    @IBOutlet private weak var separatorView: UIView!
    
    private var type: SettingsData.Section.SettingType?
    weak var delegate: SettingsCellDelegate?
    
    override func prepare() {
        actionButton.setTitle(nil, for: .normal)
        switchButton.onTintColor = Harlow.Style.tintColor
        
        type = nil
    }

    func fill(with model: Model?) {
        guard let data = model as? SettingsData.Section.Setting else { return }
        actionButton.setTitle(data.title, for: .normal)
        switchButton.isHidden = !data.hasSwitch
        switchButton.setOn(data.isOn, animated: false)
        switchButton.isUserInteractionEnabled = data.hasSwitch
        separatorView.isHidden = !data.isSeparatorVisible
        actionButton.setTitleColor(data.isActionable ? Harlow.Style.tintColor : Harlow.Style.defaultColor, for: .normal)
        actionButton.isUserInteractionEnabled = data.isActionable
        self.type = data.type
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        guard let type = type else { return }
        delegate?.switchDidChange(to: sender.isOn, for: type)
    }
    
    @IBAction func didTapAction() {
        guard let type = type else { return }
        delegate?.didTapAction(type)
    }
}
