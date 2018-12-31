//
//  ListPresenter.swift
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
import StanwoodCore

class ListPresenter: ItemPresentable {
    
    private let paramaterable: ListParamaterable
    private let actionable: ListActionable
    private weak var viewable: ListViewable?
    
    private var dataSource: ListDataSource!
    private var delegate: ListDelegate!
    private var currentFilter: DebuggerFilterView.DebuggerFilter = .analytics
    
    private var items: DataType? {
        return paramaterable.getDeguggerItems(for: currentFilter)
    }
    
    init(actionable: ListActionable, viewable: ListViewable, paramaterable: ListParamaterable) {
        self.actionable = actionable
        self.viewable = viewable
        self.paramaterable = paramaterable
        
        set(current: paramaterable.filter)
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
        
        
        viewable?.tableView.register(cells: ErrorCell.self, ErrorCell.self, bundle: Bundle.debuggerBundle())
        
        viewable?.tableView.register(cells: AnalyticsCell.self, NetworkingCell.self, bundle: Bundle.debuggerBundle())
        
        viewable?.tableView.estimatedRowHeight = 75
        viewable?.tableView.rowHeight = UITableView.automaticDimension
        
        dataSource = ListDataSource(dataType: items)
        delegate = ListDelegate(dataType: items)
        
        delegate.presenter = self
        
        refreshEmptyView()
        
        viewable?.tableView.dataSource = dataSource
        viewable?.tableView.delegate = delegate
        
        viewable?.filterView.filterCellDid(filter: currentFilter)
        
        actionable.refresh(withDelay: .milliseconds(0))
        
        switch currentFilter {
        case .networking(item: let recordable):
            if let recordable = recordable {
                present(item: recordable)
            }
        case .error(item: let recordable):
            if let recordable = recordable {
                present(item: recordable)
            }
        default: break
        }
    }
    
    func refreshEmptyView() {
        if (items?.numberOfItems ?? 0) == 0 {
            let emptyView = DebuggerEmptyView.loadFromNib(withFrame: viewable?.tableView.frame, bundle: Bundle.debuggerBundle())
            emptyView?.setLabel(with: currentFilter)
            viewable?.tableView.backgroundView = emptyView
        } else {
            viewable?.tableView.backgroundView = nil
        }
    }
    
    func present(item: Recordable) {
        actionable.present(item: item)
    }
}
