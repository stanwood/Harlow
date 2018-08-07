//
//  DebuggerParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

protocol DebuggerParameterable {
    func getDeguggerItems(for filter: DebuggerFilterView.DebuggerFilter) -> DataType?
}

extension DebuggerParamaters: DebuggerParameterable {}
