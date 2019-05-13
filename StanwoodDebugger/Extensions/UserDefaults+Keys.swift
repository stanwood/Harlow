//
//  UserDefaults+Keys.swift
//  Pods-StanwoodDebugger_Example
//
//  Created by Zolo on 2019. 05. 13..
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let hintShown = "showHint"
    }
    
    static var hintShown: Bool { return UserDefaults.standard.bool(forKey: UserDefaults.Keys.hintShown) }
    static func set(hintShown: Bool) { UserDefaults.standard.set(hintShown, forKey: UserDefaults.Keys.hintShown) }
}
