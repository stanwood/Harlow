//
//  DebuggerSettings.swift
//  Pods-StanwoodDebugger_Example
//
//  Created by Tal Zion on 25/04/2018.
//

import Foundation

class DebuggerSettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func dismissDebuggerView() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }
}
