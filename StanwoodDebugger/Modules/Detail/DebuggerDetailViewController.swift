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
    
    private var currentFilter: DebuggerFilterView.DebuggerFilter = .analytics
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        filterView = DebuggerFilterView.loadFromNib(withFrame: CGRect(x: 0, y: navigationBarHeight + statusBarHeight, width: view.bounds.width, height: 56), bundle: Bundle.debuggerBundle(from: type(of: self)))
        view.addSubview(filterView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: statusBarHeight + navigationBarHeight + filterView.frame.height, width: view.bounds.width, height: view.bounds.height - ([statusBarHeight, navigationBarHeight, tabBarHeight].reduce(0, +))), style: UITableViewStyle.plain)
        view.addSubview(tableView)
    }
    
    @objc func dismissDebuggerView() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }
}

extension DebuggerDetailViewController: DebuggerFilterViewDelegate {
    func debuggerFilterViewDidFilter(_ filter: DebuggerFilterView.DebuggerFilter) {
        self.currentFilter = filter
        tableView.reloadData()
    }
}
