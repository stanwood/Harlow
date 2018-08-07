//
//  DebuggerItem.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

struct AnalyticsItem: Typeable {
    
    enum CodingKeys: String, CodingKey {
        case eventName, category, contentType, id = "itemId", createdAt
    }
    
    var id: String?
    var eventName: String?
    var category: String?
    var contentType: String?
    var createdAt: Date?
    
    var formattedDate: String {
        guard let date = createdAt else { return "" }
        let format = "HH:mm:ss"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: date)
    }
}
