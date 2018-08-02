//
//  ListParamaterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation
import StanwoodCore

protocol ListParamaterable {
    func getDeguggerItems(for filter: DebuggerFilterView.DebuggerFilter) -> DataType?
}

extension DebuggerParamaters: ListParamaterable {

    func getDeguggerItems(for filter: DebuggerFilterView.DebuggerFilter) -> DataType? {
        switch filter {
        case .analytics: return appData.analyticsItems
        case .error, .logs, .networking, .uiTesting: return nil
        }
    }
}
