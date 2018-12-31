//
//  ErrorOverviewCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import UIKit
import StanwoodCore

class ErrorOverviewCell: ErrorCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
