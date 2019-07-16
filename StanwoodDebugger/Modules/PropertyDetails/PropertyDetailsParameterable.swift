//
//  PropertyDetailsParameterable.swift
//  StanwoodDebugger
//
//  Created by AT on 7/15/19.
//

protocol PropertyDetailsParameterable {
    var collection: PanelTypeWrapperItems { get }
}

class PropertyDetailsParemters: DebuggerParamaters, PropertyDetailsParameterable {
    
    var collection: PanelTypeWrapperItems
    
    init(collection: PanelTypeWrapperItems, appData: DebuggerData) {
        self.collection = collection
        super.init(appData: appData)
    }
    
    
}
