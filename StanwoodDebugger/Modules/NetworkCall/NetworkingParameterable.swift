//
//  NetworkingParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

protocol NetworkingParameterable {
    var item: NetworkItem { get }
}

class NetworkingParameters: DebuggerParamaters, NetworkingParameterable {
    
    let item: NetworkItem
    
    init(appData: DebuggerData, item: NetworkItem) {
        self.item = item
        super.init(appData: appData)
    }
}
