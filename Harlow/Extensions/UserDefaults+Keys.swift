//
//  UserDefaults+Keys.swift
//  Pods-Harlow_Example
//
//  Created by Zolo on 2019. 05. 13..
//

import Foundation

extension UserDefaults {
    static var isHintShown: Bool {
        get { return standard.bool(forKey: #function) }
        set { standard.set(newValue, forKey: #function) }
    }
}
