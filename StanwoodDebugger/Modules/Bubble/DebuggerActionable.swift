//
//  DebuggerActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

protocol DebuggerActionable {
    func presentListView(with filter: DebuggerFilterView.DebuggerFilter, completion: @escaping Completion)
    func presentScaleable(_ view: DebuggerScallableView)
}

extension DebuggerActions: DebuggerActionable {
    
    func presentListView(with filter: DebuggerFilterView.DebuggerFilter, completion: @escaping Completion) {
        coordinator?.presentListView(with: filter, completion: completion)
    }
    
    func presentScaleable(_ view: DebuggerScallableView) {
        view.show()
    }
}
