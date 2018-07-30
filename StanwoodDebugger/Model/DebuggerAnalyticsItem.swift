//
//  DebuggerItem.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

struct DebuggerAnalyticsItem: Typeable {
    
    enum CodingKeys: String, CodingKey {
        case eventName, category, contentType, id = "itemId"
    }
    
    var id: String?
    var eventName: String?
    var category: String?
    var contentType: String?
}
