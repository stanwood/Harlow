//
//  ListDataSource.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 18/07/2018.
//

import Foundation
import StanwoodCore

class ListDataSource: Stanwood.AbstractTableDataSource {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}
