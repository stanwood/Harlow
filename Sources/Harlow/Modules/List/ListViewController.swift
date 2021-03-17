//
//  ListViewController.swift
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

import Foundation
import UIKit

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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard tableView == nil else { return }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        filterView = DebuggerFilterView.loadFromNib(withFrame: CGRect(x: 0, y: navigationBarHeight + statusBarHeight, width: view.bounds.width, height: 56), bundle: Bundle.debuggerBundle(from: type(of: self)))
        filterView.delegate = self
        filterView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.addSubview(filterView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: statusBarHeight + navigationBarHeight + filterView.frame.height, width: view.bounds.width, height: view.bounds.height - ([statusBarHeight, navigationBarHeight, tabBarHeight].reduce(0, +))), style: .plain)
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        
        view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: nil)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.reloadData()
    }
    
    @objc func refresh() {
        tableView.reloadData()
        presenter.refreshEmptyView()
    }
    
    @objc func dismissDebuggerView() {
        NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidDismissFullscreen, object: nil)
        tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func showFilter() {
        assert(false)
    }
}

extension ListViewController: DebuggerFilterViewDelegate {
    
    func debuggerFilterViewDidFilter(_ filter: DebuggerFilterView.DebuggerFilter) {
        presenter.set(current: filter)
        presenter.refreshEmptyView()
        tableView.reloadData()
    }
}
