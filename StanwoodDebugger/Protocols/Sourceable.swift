//
//  Sourceable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

typealias Itemable = Item & Codable
typealias CellFilling = UITableViewCell & Filling

protocol Item {}

protocol Sourceable {
    var numberOfItems: Int { get }
    var numberOfSections: Int { get }
    
    subscript(indexPath: IndexPath) -> Item? { get }
    subscript(section: Int) -> Sourceable { get }
    
    func cellForItem(at indexPath: IndexPath) -> Filling.Type?
}

extension Sourceable {
    // Optional 
    func cellForItem(at indexPath: IndexPath) -> Filling.Type? { return nil }
}

protocol Filling where Self: UITableViewCell {
    func fill(with: Item?)
}
