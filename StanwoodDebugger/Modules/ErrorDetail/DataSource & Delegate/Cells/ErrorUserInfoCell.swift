//
//  ErrorUserInfoCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import UIKit
import StanwoodCore

protocol ErrorUserInfoCellDelegate: class {
    func didCopy(text: String)
}

class ErrorUserInfoCell: UITableViewCell, Fillable, Delegateble {

    @IBOutlet weak var userInfoTextView: UITextView!
    private weak var delegate: ErrorUserInfoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        main(deadline: .milliseconds(50)) { /// There is a weird black stripe added
            self.userInfoTextView.addInnerShadow(onSide: .all)
        }
    }
    
    func fill(with type: Type?) {
        guard let item = type as? ErrorItem else { return }
        userInfoTextView.text = item.error.coding?.userInfo.prettyString
    }
    
    func set(delegate: AnyObject) {
        self.delegate = delegate as? ErrorUserInfoCellDelegate
    }
    
    @IBAction func copyAction(_ sender: Any) {
        delegate?.didCopy(text: userInfoTextView.text)
    }
}
