//
//  DebuggerActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

protocol DebuggerActionable {
    func presentDetailView()
}
extension DebuggerActions: DebuggerActionable {
    
    func presentDetailView() {
        coordinator.presentDetailView()
    }
}
