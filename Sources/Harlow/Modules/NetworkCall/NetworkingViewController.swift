//
//  NetworkingViewController.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import SourceModel
import Loaf

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
    
    func setupTableView(modelCollection: ModelCollection?) {
        
        tableView.register(cells: NetworkDataBodyCell.self, NetworkOverviewCell.self, NetworkErrorCell.self, NetworkHeadersCell.self, NetworkLatencyCell.self, NetworkResponseCell.self, NetworkDataResponseCell.self, bundle: Bundle.debuggerBundle())
        
        let nib = UINib(nibName: String(describing: NetworkHeaderView.self), bundle:Bundle.debuggerBundle(from: type(of: self)))
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: NetworkHeaderView.self))
    
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        delegate = NetworkingDelegate(modelCollection: modelCollection)
        delegate.dataPresentable = self
        
        dataSource = NetworkingDataSource(modelCollection: modelCollection, delegate: self)

        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

extension NetworkingViewController: CopyPasteDelegate {
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
        Loaf(message, state: .success, sender: self).show()
    }
}

extension NetworkingViewController: DataPresentable {
    
    func present(_ data: Data?) {
        guard let data = data else { return }
        let networkData = NetworkData(data: data)
        presenter.present(data: networkData)
    }
}
