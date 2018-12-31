//
//  ErrorItem.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/12/2018.
//

import Foundation
import StanwoodCore

struct ErrorItem: Typeable, Codable, Recordable {

    let error: Stanwood.CodingBridge<NSError>
    
    init(error: NSError) {
        self.error = Stanwood.CodingBridge<NSError>(error)
    }
    
    static func == (lhs: ErrorItem, rhs: ErrorItem) -> Bool {
        return lhs.error.coding == rhs.error.coding
    }
}
