//
//  DebuggerCoordinator.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

class DebuggerCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func presentDetailView(completion: @escaping Completion) {
        
        let title = "Debugger"
        
        // Detail Nav Controller
        let deatailViewController = DebuggerDetailViewController()
        deatailViewController.title = title
        let detailNavigationController = UINavigationController(rootViewController: deatailViewController)
        let detailItem = UIBarButtonItem(barButtonSystemItem: .done, target: deatailViewController, action: #selector(DebuggerDetailViewController.dismissDebuggerView))
        deatailViewController.navigationItem.leftBarButtonItem = detailItem
        detailNavigationController.tabBarItem = UITabBarItem(title: "Debugger", image: UIImage(named: "bug_icon", in: Bundle.debuggerBundle(from: type(of: self)), compatibleWith: nil), selectedImage: nil)
        
        // Settings Nav Controller
        let settingsViewController = DebuggerDetailViewController()
        settingsViewController.title = title
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        let settingsItem = UIBarButtonItem(barButtonSystemItem: .done, target: settingsViewController, action: #selector(DebuggerSettingsViewController.dismissDebuggerView))
        settingsViewController.navigationItem.leftBarButtonItem = settingsItem
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_icon", in: Bundle.debuggerBundle(from: type(of: self)), compatibleWith: nil), selectedImage: nil)
        
        let tabBarController = DebuggerUITabBarController()
        tabBarController.setViewControllers([detailNavigationController, settingsNavigationController], animated: false)
        window.rootViewController?.present(tabBarController, animated: false, completion: completion)
    }
}
