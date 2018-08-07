//
//  AnalyticsCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import UIKit
import StanwoodCore

class AnalyticsCell: UITableViewCell, Fillable {

    @IBOutlet private var labels: [UILabel]!
    
    private(set) var item: AnalyticsItem?
    
    private enum Labels: Int {
        case name, category, id, contentType, date
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
        labels.forEach({ $0.text = nil })
    }
    
    func fill(with type: Type?) {
        guard let item = type as? AnalyticsItem else { return }
        self.item = item
        labels[Labels.name.rawValue].text = item.eventName
        labels[Labels.category.rawValue].text = item.category
        labels[Labels.id.rawValue].text = item.id
        labels[Labels.contentType.rawValue].text = item.contentType
        labels[Labels.date.rawValue].text = item.formattedDate
    }
    
}
