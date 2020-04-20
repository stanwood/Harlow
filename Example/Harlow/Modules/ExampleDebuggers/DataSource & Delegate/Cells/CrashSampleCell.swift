//
//  CrashSampleCell.swift
//  Harlow_Example
//
//  Created by Lukasz Lenkiewicz on 05/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SourceModel

class CrashSampleCell: UITableViewCell, Fillable, ActionItemCellable {
    @IBOutlet private weak var titleLabel: UILabel!
    var item: ActionItemable?

    func fill(with model: Model?) {
        guard let item = model as? CrashExample else { return }
        titleLabel.text = item.type.displayName
        self.item = item
    }
    
}
