//
//  ListViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

protocol ListViewable: class {
    var filterView: DebuggerFilterView! { get set }
    var tableView: UITableView! { get set }
}

class ListViewController: UIViewController, ListViewable {
    
    var filterView: DebuggerFilterView!
    var tableView: UITableView!
    var presenter: ListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        filterView = DebuggerFilterView.loadFromNib(withFrame: CGRect(x: 0, y: navigationBarHeight + statusBarHeight, width: view.bounds.width, height: 56), bundle: Bundle.debuggerBundle(from: type(of: self)))
        filterView.delegate = self
        filterView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.addSubview(filterView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: statusBarHeight + navigationBarHeight + filterView.frame.height, width: view.bounds.width, height: view.bounds.height - ([statusBarHeight, navigationBarHeight, tabBarHeight].reduce(0, +))), style: .plain)
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.DeuggerDidAddDebuggerItem, object: nil)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc func refresh() {
        tableView.reloadData()
    }
    
    @objc func dismissDebuggerView() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: DebuggerFilterViewDelegate {
    
    func debuggerFilterViewDidFilter(_ filter: DebuggerFilterView.DebuggerFilter) {
        self.presenter.set(current: filter)
        tableView.reloadData()
    }
}
