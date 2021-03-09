//
//  CrashCell.swift
//  Harlow
//
//  Created by Lukasz Lenkiewicz on 02/01/2019.
//

import UIKit
import SourceModel

class CrashCell: UITableViewCell, Fillable {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet private var labels: [UILabel]!

    var item: CrashItem?

    private enum Labels: Int {
        case dateAndName, description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = indicatorView.frame.width / 2
        indicatorView.layer.masksToBounds = true
    }
    
    func fill(with model: Model?) {
        guard let item = model as? CrashItem else { return }
        self.item = item

        labels[Labels.dateAndName.rawValue].text = item.formattedDate + ": " + item.name
        labels[Labels.description.rawValue].text = item.description
    }

    
}
