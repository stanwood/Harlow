//
//  CrashStackCell.swift
//  Harlow
//
//  Created by Lukasz Lenkiewicz on 03/01/2019.
//

import UIKit
import SourceModel

class CrashStackCell: UITableViewCell, Fillable {

    @IBOutlet private weak var textView: UITextView!

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutSubviews()
        self.textView.addInnerShadow(onSide: .left, shadowColor: .white)
        self.textView.addInnerShadow(onSide: .right, shadowColor: .white)
    }

    func fill(with model: Model?) {
        guard let item = model as? StackItem else { return }
        textView.text = item.text
        if item.isAppStack {
            textView.textColor = UIColor(r: 219, g: 44, b: 56)
        } else {
            textView.textColor = .lightGray
        }
        
        self.layoutSubviews()
    }
}
