//
//  NetwrokingCell.swift
//  Pods-Harlow_Example
//
//  Created by Tal Zion on 24/12/2018.
//

import UIKit
import SourceModel

class NetworkingCell: UITableViewCell, Fillable {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet private var labels: [UILabel]!
    
    var item: NetworkItem?
    
    private enum Labels: Int {
        case date, url, status
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = indicatorView.frame.width / 2
        indicatorView.layer.masksToBounds = true
    }
    
    func fill(with model: Model?) {
        guard let item = model as? NetworkItem else { return }
        self.item = item
        
        labels[Labels.date.rawValue].text = item.formattedDate
        labels[Labels.url.rawValue].text = item.url
        labels[Labels.status.rawValue].text = "\(item.code)"
        
        labels[Labels.status.rawValue].textColor = item.codeType.color
        indicatorView.backgroundColor = item.codeType.color
    }
}
