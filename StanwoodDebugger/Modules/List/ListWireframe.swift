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
        let listViewController = DebuggerListViewController()
        listViewController.title = title
        let listNavigationController = UINavigationController(rootViewController: listViewController)
        let listItem = UIBarButtonItem(barButtonSystemItem: .done, target: listViewController, action: #selector(DebuggerListViewController.dismissDebuggerView))
        listViewController.navigationItem.leftBarButtonItem = listItem
        listNavigationController.tabBarItem = UITabBarItem(title: "Debugger", image: UIImage(named: "bug_icon", in: Bundle.debuggerBundle(from: type(of: ListWireframe())), compatibleWith: nil), selectedImage: nil)
        return (listNavigationController, listViewController)
    }
    
    static func prepare(_ viewController: DebuggerListViewController, with actionable: ListActionable, _ paramaterable: ListParamaterable, filter: DebuggerFilterView.DebuggerFilter) {
        let preseter = ListPresenter(actionable: actionable, viewable: viewController, paramaterable: paramaterable, filter: filter)
        viewController.presenter = preseter
    }
}
