//
//  AbstractDelegate.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/04/2018.
//

import Foundation

class AbstractDelegate<Items: Sourceable>: NSObject, UITableViewDelegate {
    
    private(set) var items: Items
    
    required init(items: Items) {
        self.items = items
    }
    
    func update(items: Items) {
        self.items = items
    }
}
