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
    
    func presentDetailView(completion: @escaping Completion) {
        
        let title = "Debugger"
        
        // Detail Nav Controller
        let detailControllers = DetailWireframe.makeViewController(withTitle: title)
        DetailWireframe.prepare(detailControllers.viewController, with: actionable, paramaterable)
        
        // Settings Nav Controller
        let settingsViewController = DebuggerDetailViewController()
        settingsViewController.title = title
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        let settingsItem = UIBarButtonItem(barButtonSystemItem: .done, target: settingsViewController, action: #selector(DebuggerSettingsViewController.dismissDebuggerView))
        settingsViewController.navigationItem.leftBarButtonItem = settingsItem
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_icon", in: Bundle.debuggerBundle(from: type(of: self)), compatibleWith: nil), selectedImage: nil)

        
        let tabBarController = DebuggerUITabBarController()
        tabBarController.setViewControllers([detailControllers.navigationController, settingsNavigationController], animated: false)
        window.rootViewController?.present(tabBarController, animated: false, completion: completion)
    }
}
