//
//  NetworkingExampleCell.swift
//  Harlow_Example
//
//  Created by Tal Zion on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SourceModel

class NetworkingExampleCell: UITableViewCell, Fillable {

    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var methodLabel: UILabel!
    
    var item: NetworkExample?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with model: Model?) {
        guard let item = model as? NetworkExample else { return }
        urlLabel.text = item.url
        methodLabel.text = "[\(item.method.rawValue.uppercased())]"
        self.item = item
    }
}
