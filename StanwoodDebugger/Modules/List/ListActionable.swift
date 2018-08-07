//
//  ListActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

protocol ListActionable {
    func refresh(withDelay delay: DispatchTimeInterval)
}

extension DebuggerActions: ListActionable {
    func refresh(withDelay delay: DispatchTimeInterval = .milliseconds(500)) {
        appData.refresh(withDelay: delay)
    }
}
