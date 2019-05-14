//
//  UserDefaults+Keys.swift
//  Pods-StanwoodDebugger_Example
//
//  Created by Zolo on 2019. 05. 13..
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let isHintShown = "isHintShown"
    }
    
    static var isHintShown: Bool {
        get { return standard.bool(forKey: #function) }
        set { standard.set(newValue, forKey: #function) }
    }
}
