//
//  NetworkingViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore
import Toast_Swift

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
}

extension NetworkingViewController: NetworkingViewable {
    
    func setupTableView(dataType: DataType?) {
        
        tableView.register(cells: NetworkDataBodyCell.self, NetworkOverviewCell.self, NetworkErrorCell.self, NetworkHeadersCell.self, NetworkLatencyCell.self, NetworkResponseCell.self, NetworkDataResponseCell.self, bundle: Bundle.debuggerBundle())
        
        let nib = UINib(nibName: String(describing: NetworkHeaderView.self), bundle:Bundle.debuggerBundle(from: type(of: self)))
        
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: NetworkHeaderView.self))
    
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        delegate = NetworkingDelegate(dataType: dataType)
        delegate.dataPresentable = self
        
        dataSource = NetworkingDataSource(dataType: dataType, delegate: self)

        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

extension NetworkingViewController: NetworkCopyPasteDelegate {
    func didCopy(text: String, sender: UIView) {
        
        var message = String()
        UIPasteboard.general.string = text
        switch sender {
        case is NetworkHeadersCell:
            message = "Copied header to clipboard"
        case is NetworkOverviewCell:
            message = "Copied URL to clipboard"
        default: break
        }
        view.makeToast(message, duration: 3.0, position: .bottom)
    }
}

extension NetworkingViewController: DataPresentable {
    
    func present(_ data: Data?) {
        guard let data = data else { return }
        let networkData = NetworkData(data: data)
        presenter.present(data: networkData)
    }
}
