//
//  FilterCell.swift
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

protocol FilterCellDelegate: class {
    func filterCellDid(filter: DebuggerFilterView.DebuggerFilter)
}

class FilterCell: UICollectionViewCell {

    @IBOutlet private weak var filterButton: FilterUIButton!
    private var filter: DebuggerFilterView.DebuggerFilter?
    var delegate: FilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = StanwoodDebugger.Style.tintColor.cgColor
        filterButton.layer.cornerRadius = filterButton.frame.height / 2
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filterButton.setTitle(nil)
    }
    
    func fill(with filter: DebuggerFilterView.DebuggerFilter) {
        self.filter = filter
        filterButton.setTitle(filter)
    }
    
    func fill(with filter: DebuggerFilterView.DebuggerFilter, isSelected: Bool) {
        fill(with: filter)
        filterButton.set(selected: isSelected)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        guard let filter = filter else { return }
        delegate?.filterCellDid(filter: filter)
    }
    
    func select(currentFilter: DebuggerFilterView.DebuggerFilter) {
        guard let filter = filter else { return }
        filterButton.set(selected: currentFilter == filter)
    }
}
