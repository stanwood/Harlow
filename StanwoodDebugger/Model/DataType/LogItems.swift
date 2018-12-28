//
//  LogItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/12/2018.
//

import Foundation
import StanwoodCore

class LogItems: Stanwood.Elements<LogItem> {
    
    static let fileName: String = "log_items"
    
    func removeAll() {
        items.removeAll()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkingCell.self
    }
}
