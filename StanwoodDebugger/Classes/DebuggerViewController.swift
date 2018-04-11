//
//  DebuggerViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation

class DebuggerViewController: UIViewController {
    
    private var debuggerButton: DebuggerUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debuggerButton = DebuggerUIButton()
        debuggerButton.addTarget(self, action: #selector(didTapDebuggerButton(target:)), for: .touchUpInside)
        view.addSubview(debuggerButton)
        debuggerButton.activatePulse()
    }

    @objc func didTapDebuggerButton(target: UIButton) {
        StanwoodDebugger.shared.isDisplayed = true
        
        /// For testing only, will be implemented in other tickets
        let viewController = DebuggerDetailViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: viewController, action: #selector(DebuggerDetailViewController.dismissDebuggerView))
        viewController.navigationItem.leftBarButtonItem = item
        navigationController.tabBarItem = UITabBarItem(title: "Debugger", image: nil, selectedImage: nil)
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([navigationController], animated: false)
        present(tabBarController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StanwoodDebugger.shared.isDisplayed = false
    }
    
    func shouldHandle(_ point: CGPoint) -> Bool {
        if StanwoodDebugger.shared.isDisplayed {
            return true
        }
        return debuggerButton.frame.contains(point)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
}
