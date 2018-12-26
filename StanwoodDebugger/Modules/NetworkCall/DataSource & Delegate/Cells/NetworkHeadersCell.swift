//
//  NetworkHeadersCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

protocol NetworkCopyPasteDelegate: class {
    func didCopy(text: String, sender: UIView)
}

class NetworkHeadersCell: UITableViewCell, Fillable, Delegateble {

    @IBOutlet private weak var textView: UITextView!
    private weak var delegate: NetworkCopyPasteDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        main(deadline: .milliseconds(50)) { /// There is a weird black stripe added
            self.textView.addInnerShadow(onSide: .all)
        }
    }

    func fill(with type: Type?) {
        guard let headerable = type as? ResponseHeaderable else { return }
        textView.text = headerable.headers?.prettyString
    }
    
    func set(delegate: AnyObject) {
        self.delegate = delegate as? NetworkCopyPasteDelegate
    }
    
    @IBAction func actionCopy() {
        delegate?.didCopy(text: textView.text, sender: self)
    }
}
