//
//  DebuggerActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

protocol DebuggerActionable {
    func presentDetailView(completion: @escaping Completion)
    func presentScaleable(_ view: DebuggerScallableView)
}

extension DebuggerActions: DebuggerActionable {
    
    func presentDetailView(completion: @escaping Completion) {
        coordinator.presentDetailView(completion: completion)
    }
    
    func presentScaleable(_ view: DebuggerScallableView) {
        view.show()
    }
}
