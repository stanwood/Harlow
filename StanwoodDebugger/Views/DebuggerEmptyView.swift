//
//  DebuggerEmptyView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import Foundation

class DebuggerEmptyView: UIView {
    
    @IBOutlet private weak var iconLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func setLabel(with filter: DebuggerFilterView.DebuggerFilter) {
        iconLabel.text = filter.icon.rawValue
        subtitleLabel.text = filter.isUnderConstruction ? "Under construction... ¯\\_(〴)_/¯" : "Waiting for logs... ¯\\_(ツ)_/¯"
    }
}
