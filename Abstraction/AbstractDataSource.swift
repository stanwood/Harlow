//
//  AbstractDataSource.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/04/2018.
//

import Foundation

typealias Itemable = Item & Codable

protocol Item {}

protocol Sourceable {
    var numberOfItems: Int { get }
    var numberOfSections: Int { get }
    
    subscript(indexPath: IndexPath) -> Item? { get }
    subscript(section: Int) -> Sourceable { get }
    
    func cellForItem(at indexPath: IndexPath) -> Filling.Type?
}

protocol Filling where Self: UITableViewCell {
    func fill<T: Item>(with: T?)
}

class AbstractDataSource: NSObject, UITableViewDataSource {
    
    private(set) var items: Sourceable
    
    init<T: Sourceable>(items: T) {
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
        guard let cell = tableView.dequeue(cellType: cellType, for: indexPath) as? (UITableViewCell & Filling) else { fatalError("UICollectionViewCell must conform to Fillable protocol") }
        cell.fill(with: items[indexPath.section][indexPath])
    }
}
