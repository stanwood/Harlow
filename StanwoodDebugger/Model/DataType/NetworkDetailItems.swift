//
//  NetworkDetailItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import Foundation
import StanwoodCore

class NetworkDetailItems: Stanwood.Elements<NetworkItem> {
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkingCell.self
    }
}
