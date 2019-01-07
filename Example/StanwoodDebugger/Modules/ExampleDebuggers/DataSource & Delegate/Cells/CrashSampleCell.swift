//
//  CrashSampleCell.swift
//  StanwoodDebugger_Example
//
//  Created by Lukasz Lenkiewicz on 05/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import StanwoodCore

class CrashSampleCell: UITableViewCell, Fillable, ActionItemCellable {
    @IBOutlet private weak var titleLabel: UILabel!
    var item: ActionItemable?

    func fill(with type: Type?) {
        guard let item = type as? CrashExample else { return }
        titleLabel.text = item.type.displayName
        self.item = item
    }
    
}
