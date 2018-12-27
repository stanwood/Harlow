//
//  NetworkingDelegate.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import StanwoodCore

protocol DataPresentable: class {
    func present(_ data: Data?)
}
class NetworkingDelegate: Stanwood.AbstractTableDelegate {
    
    weak var dataPresentable: DataPresentable?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? NetworkDataBodyCell {
            dataPresentable?.present(cell.item?.httpBody)
        } else if let cell = tableView.cellForRow(at: indexPath) as? NetworkDataResponseCell {
            dataPresentable?.present(cell.item?.dataResponse)
        }
    }
}
