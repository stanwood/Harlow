//
//  DebuggerDetailViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

class DebuggerDetailViewController: UIViewController {
    
    var filterView: DebuggerFilterView!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        filterView = DebuggerFilterView.loadFromNib(withFrame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.height ?? 0) + statusBarHeight, width: view.bounds.width, height: 56), bundle: Bundle.debuggerBundle(from: type(of: self)))
        view.addSubview(filterView)
    }
    
    @objc func dismissDebuggerView() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }
}
