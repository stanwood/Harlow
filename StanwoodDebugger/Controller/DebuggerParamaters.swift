//
//  DebuggerParamaters.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

class DebuggerParamaters {
    
    let appData: DebuggerData
    
    init(appData: DebuggerData) {
        self.appData = appData
        
        DebuggerSettings.setDefaultSettings()
    }
}
