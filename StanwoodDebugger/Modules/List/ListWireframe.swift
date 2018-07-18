//
//  ListWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

class ListWireframe {
    private init () {}
    
    static func makeViewController(withTitle title: String) -> (navigationController: UINavigationController, viewController: DebuggerListViewController) {
        let settingsViewController = DebuggerListViewController()
        settingsViewController.title = title
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        let settingsItem = UIBarButtonItem(barButtonSystemItem: .done, target: settingsViewController, action: #selector(DebuggerSettingsViewController.dismissDebuggerView))
        settingsViewController.navigationItem.leftBarButtonItem = settingsItem
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_icon", in: Bundle.debuggerBundle(from: type(of: ListWireframe())), compatibleWith: nil), selectedImage: nil)
        return (settingsNavigationController, settingsViewController)
    }
    
    static func prepare(_ viewController: DebuggerListViewController, with actionable: ListActionable, _ paramaterable: ListParamaterable, filter: DebuggerFilterView.DebuggerFilter) {
        let preseter = ListPresenter(actionable: actionable, viewable: viewController, paramaterable: paramaterable, filter: filter)
        viewController.presenter = preseter
    }
}
