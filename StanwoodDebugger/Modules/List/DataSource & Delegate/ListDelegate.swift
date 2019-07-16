//
//  ListDelegate.swift
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
import SourceModel

protocol ListDelegateHandler: class {
    func showPeopleProperties()
    var hasUserProperties: Bool { get }
}

class ListDelegate: TableDelegate {
 
    weak var presenter: ItemPresentable?
    weak var handler: ListDelegateHandler?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? NetworkingCell,
            let item = cell.item {
            
            presenter?.present(item: item)
        } else if let cell = tableView.cellForRow(at: indexPath) as? ErrorCell,
            let item = cell.item {
            presenter?.present(item: item)
        } else if let cell = tableView.cellForRow(at: indexPath) as? CrashCell,
            let item = cell.item {
            presenter?.present(item: item)
        } else if let cell = tableView.cellForRow(at: indexPath) as? AnalyticsCell,
            let item = cell.item {
            presenter?.present(item: item)
        }

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = PeoplePropertyHeader.loadFromNib(bundle: Bundle.debuggerBundle())
        header?.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return handler?.hasUserProperties == true ? 50 : 0
    }
}


extension ListDelegate: PeoplePropertyHeaderDelegate {
    
    func showPeopleProperties() {
        handler?.showPeopleProperties()
    }
}
