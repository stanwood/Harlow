//
//  DebuggerCoordinator.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

class DebuggerCoordinator {
    
    private let window: UIWindow
    private let actionable: DebuggerActions
    private let paramaterable: DebuggerParamaters
    
    init(window: UIWindow, actionable: DebuggerActions, paramaterable: DebuggerParamaters) {
        self.window = window
        self.actionable = actionable
        self.paramaterable = paramaterable
    }
    
    func presentListView(with filter: DebuggerFilterView.DebuggerFilter, completion: @escaping Completion) {
        
        let title = "Debugger"
        
        // Detail Nav Controller
        let detailControllers = ListWireframe.makeViewController(withTitle: title)
        ListWireframe.prepare(detailControllers.viewController, with: actionable, paramaterable, filter: filter)
        
        // Settings Nav Controller
        let settingsControllers = SettingsWireframe.makeViewController(withTitle: title)
        SettingsWireframe.prepare(settingsControllers.viewController, with: actionable, paramaterable)
        
        let tabBarController = DebuggerUITabBarController()
        tabBarController.setViewControllers([
            detailControllers.navigationController,
            settingsControllers.navigationController], animated: false)
        
        window.rootViewController?.present(tabBarController, animated: false, completion: completion)
    }
}
