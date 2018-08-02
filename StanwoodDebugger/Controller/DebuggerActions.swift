//
//  DebuggerActions.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

class DebuggerActions {
    weak var coordinator: DebuggerCoordinator?
    
    let appData: DebuggerData
    
    init(appData: DebuggerData) {
        self.appData = appData
    }
}
