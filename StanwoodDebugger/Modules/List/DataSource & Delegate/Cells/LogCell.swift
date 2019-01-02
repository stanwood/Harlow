//
//  LogCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/01/2019.
//

import UIKit
import StanwoodCore

class LogCell: UITableViewCell, Fillable {

    @IBOutlet private weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        main(deadline: .milliseconds(50)) { /// There is a weird black stripe added
            self.textView.addInnerShadow(onSide: .left)
            self.textView.addInnerShadow(onSide: .right)
        }
    }
    
    func fill(with type: Type?) {
        guard let item = type as? LogItem else { return }
        textView.text = item.text
    }
}
