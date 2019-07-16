//
//  AnalyticsCell.swift
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

class AnalyticsCell: UITableViewCell, Fillable {

    @IBOutlet private var labels: [UILabel]!
    
    @IBOutlet private var collapsingStacks: [UIStackView]!
    @IBOutlet private weak var superPropertyStackView: UIStackView!
    private(set) var item: AnalyticsItem?
    private enum Labels: Int {
        case eventName, date, screenName, category, itemId, contentType
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
        labels.forEach({ $0.text = nil })
    }
    
    func fill(with model: Model?) {
      
        guard let item = model as? AnalyticsItem else { return }
        
        /// Show or hide properties depending on type
        let hasSuperProperty = item.superProperties != nil
        self.item = item
        
        labels[Labels.eventName.rawValue].text = item.eventName ?? String.defaultValue
        labels[Labels.date.rawValue].text = item.formattedDate
        labels[Labels.screenName.rawValue].text = item.screenName ?? String.defaultValue
        
        labels[Labels.category.rawValue].text = item.category ?? String.defaultValue
        labels[Labels.itemId.rawValue].text = item.itemId ?? String.defaultValue
        labels[Labels.contentType.rawValue].text = item.contentType ?? String.defaultValue
        
        collapsingStacks.forEach { (stack) in
            stack.isHidden = hasSuperProperty
        }
        
        superPropertyStackView.isHidden = !hasSuperProperty
    }
}
