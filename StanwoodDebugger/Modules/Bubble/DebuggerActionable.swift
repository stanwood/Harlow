//
//  DebuggerActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

protocol DebuggerActionable {
    func presentDetailView()
    func presentScaleable(_ view: DebuggerScallableView)
}

extension DebuggerActions: DebuggerActionable {
    
    func presentDetailView() {
        coordinator.presentDetailView()
    }
    
    func presentScaleable(_ view: DebuggerScallableView) {
        view.show()
    }
}
