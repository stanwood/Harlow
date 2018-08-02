//
//  DebuggerItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

class AnalyticItems: Stanwood.Elements<DebuggerAnalyticsItem> {
    
    static let fileName: String = "analytics_items"
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return AnalyticsCell.self
    }
}
