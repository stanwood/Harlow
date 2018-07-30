//
//  SettingsWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 30/07/2018.
//

import Foundation

class SettingsWireframe {
    
    private init () {}
    
    static func makeViewController(withTitle title: String) -> (navigationController: UINavigationController, viewController: SettingsViewController) {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = title
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        let settingsItem = UIBarButtonItem(barButtonSystemItem: .done, target: settingsViewController, action: #selector(DebuggerListViewController.dismissDebuggerView))
        settingsViewController.navigationItem.leftBarButtonItem = settingsItem
        
        let image: UIImage? = UIImage(named: "settings_icon", in: Bundle.debuggerBundle(from: type(of: SettingsWireframe())), compatibleWith: nil)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: image, selectedImage: nil)
        
        return (settingsNavigationController, settingsViewController)
    }
    
    
}
