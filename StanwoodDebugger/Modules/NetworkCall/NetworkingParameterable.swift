//
//  NetworkingParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import StanwoodCore

protocol NetworkingParameterable {
    var item: NetworkItem { get }
    var sections: NetworkDetailISections { get set }
}

class NetworkingParameters: DebuggerParamaters, NetworkingParameterable {
    
    let item: NetworkItem
    var sections: NetworkDetailISections
    
    init(appData: DebuggerData, item: NetworkItem) {
        self.item = item
        
        var sections: [Stanwood.Sections.Section] = []
        
        sections.append(NetworkOverviewSection(items: [item]))
        sections.append(NetworkLatencySection(items: [item]))
        
        if item.headers != nil, item.headers?.count ?? 0 > 0 {
            sections.append(NetworkHeadersSection(items: [item]))
        }
        
        if item.httpBody != nil {
            sections.append(NetworkBodySection(items: [item]))
        }
        
        if item.dataResponse != nil {
            sections.append(NetworkDataSection(items: [item]))
        }
        
        sections.append(NetworkResponseSection(items: [item]))
        sections.append(NetworkErrorSection(items: [item]))
        
        
        self.sections = NetworkDetailISections(items: sections)
        
        super.init(appData: appData)
    }
}
