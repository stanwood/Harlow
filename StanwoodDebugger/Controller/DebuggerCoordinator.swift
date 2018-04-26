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
        
        /// For testing only, will be implemented in other tickets
        let viewController = DebuggerDetailViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: viewController, action: #selector(DebuggerDetailViewController.dismissDebuggerView))
        viewController.navigationItem.leftBarButtonItem = item
        navigationController.tabBarItem = UITabBarItem(title: "Debugger", image: nil, selectedImage: nil)
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([navigationController], animated: false)
        window.rootViewController?.present(tabBarController, animated: false, completion: completion)
    }
}
