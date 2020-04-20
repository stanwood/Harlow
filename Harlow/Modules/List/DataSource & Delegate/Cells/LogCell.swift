//
//  LogCell.swift
//  Harlow
//
//  Created by Tal Zion on 02/01/2019.
//

import UIKit
import SourceModel

class LogCell: UITableViewCell, Fillable {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textViewTopLayoutConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutSubviews()
        self.textView.addInnerShadow(onSide: .left, shadowColor: .white)
        self.textView.addInnerShadow(onSide: .right, shadowColor: .white)
    }

    func fill(with model: Model?) {
        guard let item = model as? LogItem else { return }
        textView.text = item.text
        
        layoutSubviews()
    }
    

}
