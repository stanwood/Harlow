//
//  ErrorCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import UIKit
import StanwoodCore

class ErrorCell: UITableViewCell, Fillable {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: ErrorItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = indicatorView.frame.width / 2
    }
    
    func fill(with type: Type?) {
        guard let item = type as? ErrorItem else { return }
        self.item = item
        
        domainLabel.text = item.error.coding?.domain
        descriptionLabel.text = item.error.coding?.localizedDescription
    }
}
