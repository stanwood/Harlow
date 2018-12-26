//
//  DataDetailParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

protocol DataDetailParameterable {
    var networkData: NetworkData { get }
}

class DataDetailParameters: DebuggerParamaters, DataDetailParameterable {
    
    let networkData: NetworkData
    
    init(appData: DebuggerData, data: NetworkData) {
        networkData = data
        super.init(appData: appData)
    }
}
