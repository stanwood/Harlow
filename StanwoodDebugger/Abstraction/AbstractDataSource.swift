//
//  AbstractDataSource.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/04/2018.
//

import Foundation

class AbstractDataSource<Items: Sourceable>: NSObject, UITableViewDataSource {

    private(set) var items: Items
    
    required init(items: Items) {
        self.items = items
    }
    
    func update(items: Items) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.numberOfItems
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = items.cellForItem(at: indexPath) as? UITableViewCell.Type else { fatalError("You need to subclass Stanwood.Elements and override cellType(forItemAt:)") }
        guard let cell = tableView.dequeue(cellType: cellType, for: indexPath) as? CellFilling else { fatalError("UICollectionViewCell must conform to Fillable protocol") }
        cell.fill(with: items[indexPath.section][indexPath])
        return cell
    }
}
