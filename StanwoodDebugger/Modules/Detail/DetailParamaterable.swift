//
//  DetailParamaterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

protocol DetailParamaterable {
    var deguggerItems: DebuggerElements { get }
}

extension DebuggerParamaters: DetailParamaterable {

    var deguggerItems: DebuggerElements {
        return appData.items
    }
}
