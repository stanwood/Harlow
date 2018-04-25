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

    @IBOutlet private weak var filterButton: UIButton!
    private var filter: DebuggerFilterView.DebuggerFilter?
    var delegate: FilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor.blue.cgColor
        filterButton.layer.cornerRadius = filterButton.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filterButton.setTitle(nil, for: .normal)
    }
    
    func fill(with filter: DebuggerFilterView.DebuggerFilter) {
        self.filter = filter
        filterButton.setTitle(filter.rawValue, for: .normal)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        guard let filter = filter else { return }
        delegate?.filterCellDid(filter: filter)
    }
}
