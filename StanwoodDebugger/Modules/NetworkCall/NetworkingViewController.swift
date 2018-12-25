//
//  NetworkingViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

class NetworkingViewController: UIViewController, SourceTypePresentable {

    // MARK:- Properties

    var presenter: NetworkingPresenter!
    var dataSource: NetworkingDataSource!
    var delegate: NetworkingDelegate!
    
    // MARK:- Outlets

    var tableView: UITableView!
    
    // MARK:- Typealias

    typealias DataSource = NetworkingDataSource
    typealias Delegate = NetworkingDelegate
    
    // MARK:- LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        tableView = UITableView(frame: CGRect(x: 0, y: statusBarHeight + navigationBarHeight, width: view.bounds.width, height: view.bounds.height - ([statusBarHeight, navigationBarHeight, tabBarHeight].reduce(0, +))), style: .plain)
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        
        view.addSubview(tableView)
        
        presenter.viewDidLoad()
    }
    
    @objc func dismissDebuggerView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func showFilter() {
    
    }
}

extension NetworkingViewController: NetworkingViewable {
    
    func setupTableView(dataType: DataType?) {
        
        tableView.register(cells: NetworkBodyCell.self, NetworkOverviewCell.self, NetworkErrorCell.self, NetworkDataCell.self, NetworkHeadersCell.self, NetworkLatencyCell.self, NetworkResponseCell.self, bundle: Bundle.debuggerBundle())
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        delegate = NetworkingDelegate(dataType: dataType)
        dataSource = NetworkingDataSource(dataType: dataType)

        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
