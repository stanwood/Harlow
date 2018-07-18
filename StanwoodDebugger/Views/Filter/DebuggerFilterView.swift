//
//  DebuggerFilterView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/04/2018.
//

import Foundation

protocol DebuggerFilterViewDelegate: class {
    func debuggerFilterViewDidFilter(_ filter: DebuggerFilterView.DebuggerFilter)
}

class DebuggerFilterView: UIView {
    
    enum DebuggerFilter: String {
        case
        analytics = "   Analytics   ",
        error = "   Errors   ",
        uiTesting = "   UI Testing   ",
        networking = "   Networking   ",
        logs = "   Logs   "
        
        static var allFilters: [DebuggerFilter] = [.analytics, .error, .uiTesting, .networking, .logs]
    }
    
    var currnetFilter: DebuggerFilter = .analytics
    
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
    }
}

extension DebuggerFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DebuggerFilter.allFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: FilterCell.self, for: indexPath)
        cell.fill(with: DebuggerFilter.allFilters[indexPath.row])
        cell.delegate = self
        cell.set(selected: DebuggerFilter.allFilters[indexPath.row] == currnetFilter)
        return cell
    }
}

extension DebuggerFilterView: FilterCellDelegate {
    
    func filterCellDid(filter: DebuggerFilterView.DebuggerFilter) {
        self.currnetFilter = filter
        
        for cell in collectionView.visibleCells {
            (cell as? FilterCell)?.select(currentFilter: currnetFilter)
        }
        
        delegate?.debuggerFilterViewDidFilter(filter)
    }
}
