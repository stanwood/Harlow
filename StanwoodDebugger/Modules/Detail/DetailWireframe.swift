//
//  DetailWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

class DetailWireframe {
    private init () {}
    
    static func makeViewController(withTitle title: String) -> (navigationController: UINavigationController, viewController: DebuggerDetailViewController) {
        let settingsViewController = DebuggerDetailViewController()
        settingsViewController.title = title
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        let settingsItem = UIBarButtonItem(barButtonSystemItem: .done, target: settingsViewController, action: #selector(DebuggerSettingsViewController.dismissDebuggerView))
        settingsViewController.navigationItem.leftBarButtonItem = settingsItem
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_icon", in: Bundle.debuggerBundle(from: type(of: DetailWireframe())), compatibleWith: nil), selectedImage: nil)
        return (settingsNavigationController, settingsViewController)
    }
    
    static func prepare(_ viewController: DebuggerDetailViewController, with actionable: DetailActionable, _ paramaterable: DetailParamaterable) {
        let preseter = DetailPresenter(actionable: actionable, viewable: viewController, paramaterable: paramaterable)
        viewController.presenter = preseter
    }
}
