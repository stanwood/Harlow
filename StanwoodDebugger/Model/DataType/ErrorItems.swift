//
//  ErrorItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/12/2018.
//

import Foundation
import StanwoodCore

class ErrorItems: Stanwood.Elements<ErrorItem> {
    
    static let fileName: String = "error_items"
    
    func removeAll() {
        items.removeAll()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkingCell.self
    }
}
