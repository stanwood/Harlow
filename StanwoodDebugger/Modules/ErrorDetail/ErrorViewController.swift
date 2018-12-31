//
//  ErrorViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import UIKit
import StanwoodCore

class ErrorViewController: UIViewController, SourceTypePresentable {

    // MARK:- Properties

    var presenter: ErrorPresenter!
    var dataSource: ErrorDataSource!
    var delegate: ErrorDelegate!
    
    // MARK:- Outlets

    var tableView: UITableView!
    
    // MARK:- Typealias

    typealias DataSource = ErrorDataSource
    typealias Delegate = ErrorDelegate
    
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
}

extension ErrorViewController: ErrorViewable {
    
    func setupTableView(dataType: DataType?) {
        
        tableView.register(cells: ErrorOverviewCell.self, ErrorCodeCell.self, ErrorUserInfoCell.self, bundle: Bundle.debuggerBundle())
        
        let nib = UINib(nibName: String(describing: NetworkHeaderView.self), bundle:Bundle.debuggerBundle(from: type(of: self)))
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: NetworkHeaderView.self))
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        delegate = ErrorDelegate(dataType: dataType)
        dataSource = ErrorDataSource(dataType: dataType, delegate: self)

        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

extension ErrorViewController: ErrorUserInfoCellDelegate {
    func didCopy(text: String) {
        UIPasteboard.general.string = text
        view.makeToast("Copied user info to clipboard", duration: 3.0, position: .bottom)
    }
}
