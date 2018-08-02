//
//  DebuggerParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation

protocol DebuggerParameterable {
    var items: AnalyticItems { get }
}

extension DebuggerParamaters: DebuggerParameterable {
    
    var items: AnalyticItems {
        return appData.analyticsItems
    }
}
