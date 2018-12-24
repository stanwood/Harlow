//
//  NetworkItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/12/2018.
//

import Foundation
import StanwoodCore

class NetworkItems: Stanwood.Elements<NetworkItem> {
    
    static let fileName: String = "network_items"
    
    func removeAll() {
        items.removeAll()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetwrokingCell.self
    }
}
