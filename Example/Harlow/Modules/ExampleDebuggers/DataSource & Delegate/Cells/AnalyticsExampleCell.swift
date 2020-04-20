//
//  AnalyticsCell.swift
//  Harlow_Example
//
//  Created by Tal Zion on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SourceModel

class AnalyticsExampleCell: UITableViewCell, Fillable, ActionItemCellable {
    @IBOutlet private weak var analyticsLabel: UILabel!
    
    var item: ActionItemable?
    
    func fill(with model: Model?) {
        guard let item = model as? AnalyticExample else { return }
        self.item = item
        analyticsLabel.text = item.type.title
    }
}
