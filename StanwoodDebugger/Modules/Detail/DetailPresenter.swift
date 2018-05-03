//
//  DetailPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

class DetailPresenter {
    
    private let paramaterable: DetailParamaterable
    private let actionable: DetailActionable
    private weak var viewable: DetailViewable?
    
    private var dataSource: AbstractDataSource<DebuggerElements>!
    private var delegate: AbstractDelegate<DebuggerElements>!
    private var currentFilter: DebuggerFilterView.DebuggerFilter = .analytics
    
    private var items: DebuggerElements {
        return paramaterable.deguggerItems
    }
    
    init(actionable: DetailActionable, viewable: DetailViewable, paramaterable: DetailParamaterable) {
        self.actionable = actionable
        self.viewable = viewable
        self.paramaterable = paramaterable
    }
    
    func set(current filter: DebuggerFilterView.DebuggerFilter) {
        self.currentFilter = filter
    }
    
    func viewDidLoad() {
        viewable?.tableView.estimatedRowHeight = 75
        viewable?.tableView.rowHeight = UITableViewAutomaticDimension
        
        dataSource = AbstractDataSource(items: items)
        delegate = AbstractDelegate(items: items)
        
        viewable?.tableView.dataSource = dataSource
        viewable?.tableView.delegate = delegate
    }
}
