//
//  ListDelegate.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

class ListDelegate: Stanwood.AbstractTableDelegate {
 
    weak var presenter: ListPresenter?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? AnalyticsCell,
        let item = cell.item else { return }
        
    }
}
