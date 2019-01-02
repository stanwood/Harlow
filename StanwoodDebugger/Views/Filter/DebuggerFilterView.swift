//
//  DebuggerFilterView.swift
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

import Foundation
import StanwoodCore

protocol DebuggerFilterViewDelegate: class {
    func debuggerFilterViewDidFilter(_ filter: DebuggerFilterView.DebuggerFilter)
}

class DebuggerFilterView: UIView {
    
    enum DebuggerFilter {
        case analytics, error(item: Recordable?), crashes, networking(item: Recordable?), logs
        
        var label: String {
            switch self {
            case .analytics: return "   Analytics   "
            case .error: return "   Errors   "
            case .logs: return "   Logs   "
            case .networking: return "   Networking   "
            case .crashes: return "   Crashes   "
            }
        }
        var isUnderConstruction: Bool {
            switch self {
            case .error, .analytics, .networking, .logs: return false
            case .crashes: return true
            }
        }
        
        var icon: DebuggerIconLabel.DebuggerIcons {
            switch self {
            case .analytics: return .analytics
            case .networking: return .networking
            case .error: return .error
            case .logs: return .logs
            case .crashes: return .crashes
            }
        }
        
        static var allFilters: [DebuggerFilter] = [.analytics, .networking(item: nil), .error(item: nil), .crashes, .logs]
    }
    
    var currnetFilter: DebuggerFilter = .analytics
    
    weak var delegate: DebuggerFilterViewDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.1)
        collectionView.register(cell: FilterCell.self, bundle: Bundle.debuggerBundle(from: type(of: self)))
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        collectionView.set(spacing: 0)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        main(deadline: .milliseconds(50)) {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}



extension DebuggerFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DebuggerFilter.allFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: FilterCell.self, for: indexPath)
        cell.delegate = self
        cell.fill(with: DebuggerFilter.allFilters[indexPath.row], isSelected: DebuggerFilter.allFilters[indexPath.row].label == currnetFilter.label)
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
