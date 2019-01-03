//
//  NetworkHeadersCell.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textView.addInnerShadow(onSide: .all)
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
