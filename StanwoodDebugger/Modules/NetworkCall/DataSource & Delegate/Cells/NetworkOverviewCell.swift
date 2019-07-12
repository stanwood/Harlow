//
//  NetworkOverviewCell.swift
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

class NetworkOverviewCell: UITableViewCell, Fillable, Delegateble {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet private var labels: [UILabel]!
    
    private weak var delegate: CopyPasteDelegate?
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
    
    func fill(with model: Model?) {
        guard let item = model as? NetworkOverviewable else { return }
        self.item = item
        
        labels[Labels.date.rawValue].text = item.formattedDate
        labels[Labels.url.rawValue].text = item.url
        labels[Labels.status.rawValue].text = "\(item.code)"
        
        labels[Labels.status.rawValue].textColor = item.codeType.color
        indicatorView.backgroundColor = item.codeType.color
    }
    
    func set(delegate: AnyObject) {
        self.delegate = delegate as? CopyPasteDelegate
    }
    
    @IBAction func copyAction() {
        delegate?.didCopy(text: item?.url ?? "", sender: self)
    }
    
}
