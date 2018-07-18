//
//  DebuggerItem.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

struct DebuggerAnalyticsParameters: Typeable {

    var id: String? { return action }
    
    var label: String?
    var action: String?
    var category: String?
}

struct DebuggerAnalyticsItem: Typeable {
    var id: String? {
        return name
    }
    var name: String?
    var parameters: DebuggerAnalyticsParameters?
}
