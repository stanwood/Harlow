//
//  NetworkOverviewCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

class NetworkOverviewCell: UITableViewCell, Fillable, Delegateble {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet private var labels: [UILabel]!
    
    private weak var delegate: NetworkCopyPasteDelegate?
    private var item: NetworkOverviewable?
    
    private enum Labels: Int {
        case date, url, status
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = indicatorView.frame.width / 2
        indicatorView.layer.masksToBounds = true
        selectionStyle = .none
    }
    
    func fill(with type: Type?) {
        guard let item = type as? NetworkOverviewable else { return }
        self.item = item
        
        labels[Labels.date.rawValue].text = item.formattedDate
        labels[Labels.url.rawValue].text = item.url
        labels[Labels.status.rawValue].text = "\(item.code)"
        
        labels[Labels.status.rawValue].textColor = item.codeType.color
        indicatorView.backgroundColor = item.codeType.color
    }
    
    func set(delegate: AnyObject) {
        self.delegate = delegate as? NetworkCopyPasteDelegate
    }
    
    @IBAction func copyAction() {
        delegate?.didCopy(text: item?.url ?? "", sender: self)
    }
    
}
