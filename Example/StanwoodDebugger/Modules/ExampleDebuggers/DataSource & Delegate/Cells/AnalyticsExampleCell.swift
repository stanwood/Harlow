//
//  AnalyticsCell.swift
//  StanwoodDebugger_Example
//
//  Created by Tal Zion on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import StanwoodCore

class AnalyticsExampleCell: UITableViewCell, Fillable {

    @IBOutlet private weak var analyticsLabel: UILabel!
    
    var item: AnalyticExample?
    
    func fill(with type: Type?) {
        guard let item = type as? AnalyticExample else { return }
        self.item = item
        analyticsLabel.text = item.type.title
    }
}
