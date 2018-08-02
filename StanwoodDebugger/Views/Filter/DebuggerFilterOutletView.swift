//
//  DebuggerFilterView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/04/2018.
//

import Foundation

class DebuggerFilterOutletView: UIView {

    var currnetFilter: DebuggerFilterView.DebuggerFilter = .analytics

    weak var delegate: DebuggerFilterViewDelegate?
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.black.withAlphaComponent(0.1)
        collectionView.register(cell: FilterCell.self, bundle: Bundle.debuggerBundle(from: type(of: self)))
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let container = loadFromOutlet(bundle: Bundle.debuggerBundle(from: type(of: self)))
        container?.backgroundColor = .clear
    }
}

extension DebuggerFilterOutletView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DebuggerFilterView.DebuggerFilter.allFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: FilterCell.self, for: indexPath)
        cell.delegate = self
        cell.fill(with: DebuggerFilterView.DebuggerFilter.allFilters[indexPath.row], isSelected: DebuggerFilterView.DebuggerFilter.allFilters[indexPath.row] == currnetFilter)
        return cell
    }
}

extension DebuggerFilterOutletView: FilterCellDelegate {

    func filterCellDid(filter: DebuggerFilterView.DebuggerFilter) {
        self.currnetFilter = filter

        for cell in collectionView.visibleCells {
            (cell as? FilterCell)?.select(currentFilter: currnetFilter)
        }

        delegate?.debuggerFilterViewDidFilter(filter)
    }
}
