//
//  FilterCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/04/2018.
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
