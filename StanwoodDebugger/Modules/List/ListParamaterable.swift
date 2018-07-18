//
//  ListParamaterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation
import StanwoodCore

protocol ListParamaterable {
    var deguggerItems: DataType { get }
}

extension DebuggerParamaters: ListParamaterable {

    var deguggerItems: DataType {
        return appData.analyticsItems // Temp
    }
}
