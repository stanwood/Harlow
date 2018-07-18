//
//  DebuggerData.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation
import StanwoodCore

class DebuggerData {
    
    var analyticsItems: AnalyticItems
    
    init() {
        self.analyticsItems = AnalyticItems.loadFromFile() ?? AnalyticItems(items: [])
        

        NotificationCenter.default.addObservers(self, observers:
            Stanwood.Observer(selector: #selector(didReceiveAnalyticsItem(_:)), name: .DebuggerDidReceiveAnalyticsItem),
                                                Stanwood.Observer(selector: #selector(didReceiveLogItem(_:)), name: .DeuggerDidReceiveLogItem),
                                                Stanwood.Observer(selector: #selector(didReceiveErrorItem(_:)), name: .DeuggerDidReceiveErrorItem),
                                                Stanwood.Observer(selector: #selector(didReceiveUITestingItem(_:)), name: .DeuggerDidReceiveUITestingItem),
                                                Stanwood.Observer(selector: #selector(didReceiveNetworkingItem(_:)), name: .DeuggerDidReceiveNetworkingItem)
        )
        
        tempSetItems()
    }
    
    func tempSetItems() {
        self.analyticsItems = try! JSONDecoder().decode(AnalyticItems.self, from: analytics_data)
    }

    @objc func didReceiveAnalyticsItem(_ notification: Notification) {
       
    }
    
    @objc func didReceiveErrorItem(_ notification: Notification) {
        
    }
    
    @objc func didReceiveNetworkingItem(_ notification: Notification) {
        
    }
    
    @objc func didReceiveLogItem(_ notification: Notification) {

    }
    
    @objc func didReceiveUITestingItem(_ notification: Notification) {
    
    }
    
    func save() {
        try? analyticsItems.save()
    }
}


let analytics_data: Data =
"""
{
"items" : [
{
"name" : "user_action",
"parameters": {
"label" : "home",
"action" : "purchases",
"category" : "user"
}
},
{
"name" : "user_action",
"parameters": {
"label" : "home",
"action" : "purchases"
}
},{
"name" : "user_action",
"parameters": {
"label" : "home",
"category" : "user"
}
},{
"name" : "user_action",
"parameters": {
"action" : "purchases",
"category" : "user"
}
}
]
}
""".data(using: .utf8)!
