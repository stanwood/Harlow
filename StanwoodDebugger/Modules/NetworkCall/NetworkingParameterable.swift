//
//  NetworkingParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

protocol NetworkingParameterable {
    var item: NetworkItem { get }
    var items: NetworkDetailItems { get set }
}

class NetworkingParameters: DebuggerParamaters, NetworkingParameterable {
    
    let item: NetworkItem
    var items: NetworkDetailItems
    
    init(appData: DebuggerData, item: NetworkItem) {
        self.item = item
        self.items = NetworkDetailItems(items: [item])
        super.init(appData: appData)
    }
}
