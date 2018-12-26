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

class DebuggerFilterOutletView: UIView {
    
    var currnetFilter: DebuggerFilterView.DebuggerFilter = .analytics
    
    weak var delegate: DebuggerFilterViewDelegate?
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.collectionView.register(cell: FilterCell.self, bundle: Bundle.debuggerBundle(from: type(of: self)))
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
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
