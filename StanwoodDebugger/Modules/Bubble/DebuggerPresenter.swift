//
//  DebuggerPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

class DebuggerPresenter {
    
    weak var debuggerable: Debugging!
    private var actionable: DebuggerActionable
    var parameterable: DebuggerParameterable
    private weak var viewable: DebuggerViewable?
    
    init(debuggerable: Debugging, actionable: DebuggerActionable, viewable: DebuggerViewable, parameterable: DebuggerParameterable) {
        self.debuggerable = debuggerable
        self.actionable = actionable
        self.viewable = viewable
        self.parameterable = parameterable
    }
    
    func presentDetailView(with filter: DebuggerFilterView.DebuggerFilter, completion: @escaping Completion) {
        actionable.presentListView(with: filter, completion: completion)
    }
    
    func presentScaled(_ view: DebuggerScallableView) {
        view.presenter = self
        viewable?.debuggerScallableView?.configureTableView(with: parameterable.getDeguggerItems(for: .analytics))
        actionable.presentScaleable(view)
    }
    
    func refresh() {
        actionable.refresh(withDelay: .milliseconds(500))
    }
}
