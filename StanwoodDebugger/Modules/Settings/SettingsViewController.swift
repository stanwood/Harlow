//
//  DebuggerSettings.swift
//  Pods-StanwoodDebugger_Example
//
//  Created by Tal Zion on 25/04/2018.
//

import Foundation

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    @objc func dismissDebuggerView() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }
}
