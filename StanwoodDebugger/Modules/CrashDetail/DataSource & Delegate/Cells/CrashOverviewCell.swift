//
//  SettingsData.swift
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
import SourceModel

class CrashOverviewCell: UITableViewCell, Fillable, Delegateble {

    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!

    private var item: CrashItem?

    private weak var delegate: CopyPasteDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = indicatorView.frame.width / 2
    }

    func set(delegate: AnyObject) {
        self.delegate = delegate as? CopyPasteDelegate
    }

    func fill(with model: Model?) {
        guard let item = model as? CrashItem else { return }
        self.item = item
        titleLabel.text = item.name
        descriptionLabel.text = item.description
        infoLabel.text = item.appInfo
    }
    
    @IBAction private func copyAction() {
        guard let item = self.item else { return }
        var copyText = "\(item.name)\n"
            + "\(item.description)\n"
            + "\(item.appInfo)\n\n"
        item.stack.forEach { copyText += "\($0.text)\n" }
        delegate?.didCopy(text: copyText, sender: self)
    }

}
