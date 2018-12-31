//
//  ErrorParameterable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import StanwoodCore

protocol ErrorParameterable {
    var item: ErrorItem { get }
    var sections: ErrorDetailISections { get set }
}

class ErrorParameters: DebuggerParamaters, ErrorParameterable {
    let item: ErrorItem
    var sections: ErrorDetailISections
    
    init(appData: DebuggerData, item: ErrorItem) {
        self.item = item
        
        var sections: [Stanwood.Sections.Section] = []
        
        sections.append(ErrorOverviewSection(items: [item]))
        if item.error.coding?.userInfo.count ?? 0 > 0 {
            sections.append(ErrorUserInfoSection(items: [item]))
        }
        sections.append(ErrorCodeSection(items: [item]))
        
        self.sections = ErrorDetailISections(items: sections)
        super.init(appData: appData)
    }
}
