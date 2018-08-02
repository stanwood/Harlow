//
//  SettingsCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import UIKit
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
        type = nil
    }

    func fill(with type: Type?) {
        guard let data = type as? SettingsData.Section.Setting else { return }
        actionButton.setTitle(data.title, for: .normal)
        switchButton.isHidden = !data.hasSwitch
        switchButton.setOn(data.isOn, animated: false)
        switchButton.isUserInteractionEnabled = data.hasSwitch
        separatorView.isHidden = !data.isSeparatorVisible
        actionButton.setTitleColor(data.isActionable ? StanwoodDebugger.Style.tintColor : StanwoodDebugger.Style.defaultColor, for: .normal)
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
