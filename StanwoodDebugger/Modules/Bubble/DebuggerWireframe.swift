//
//  DebuggerWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation

class DebuggerWireframe {
    
    static func makeViewController() -> DebuggerViewController {
        return DebuggerViewController()
    }
    
    static func prepare(_ viewController: DebuggerViewController?, with actions: DebuggerActionable, and parameters: DebuggerParameterable, for debuggerable: Debuggerable) {
        guard let viewController = viewController else { return }
        let presenter = DebuggerPresenter(debuggerable: debuggerable, actionable: actions, viewable: viewController, parameterable: parameters)
        viewController.presenter = presenter
    }
}
