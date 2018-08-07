//
//  ListPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation
import StanwoodCore

class ListPresenter {
    
    private let paramaterable: ListParamaterable
    private let actionable: ListActionable
    private weak var viewable: ListViewable?
    
    private var dataSource: ListDataSource!
    private var delegate: ListDelegate!
    private var currentFilter: DebuggerFilterView.DebuggerFilter = .analytics
    
    private var items: DataType? {
        return paramaterable.getDeguggerItems(for: currentFilter)
    }
    
    init(actionable: ListActionable, viewable: ListViewable, paramaterable: ListParamaterable, filter: DebuggerFilterView.DebuggerFilter) {
        self.actionable = actionable
        self.viewable = viewable
        self.paramaterable = paramaterable
        
        set(current: filter)
    }
    
    func set(current filter: DebuggerFilterView.DebuggerFilter) {
        currentFilter = filter
        refreshSource()
    }
    
    private func refreshSource() {
        dataSource?.update(with: items)
        delegate?.update(with: items)
    }
    
    func viewDidLoad() {
        
        viewable?.tableView.register(UINib(nibName: AnalyticsCell.identifier, bundle: Bundle.debuggerBundle()), forCellReuseIdentifier: AnalyticsCell.identifier)
        
        viewable?.tableView.estimatedRowHeight = 75
        viewable?.tableView.rowHeight = UITableViewAutomaticDimension
        
        dataSource = ListDataSource(dataObject: items)
        delegate = ListDelegate(dataObject: items)
        
        delegate.presenter = self
        
        viewable?.tableView.dataSource = dataSource
        viewable?.tableView.delegate = delegate
        
        viewable?.filterView.filterCellDid(filter: currentFilter)
        
        actionable.refresh(withDelay: .milliseconds(0))
    }
}
