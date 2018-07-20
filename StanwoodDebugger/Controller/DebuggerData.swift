//
//  DebuggerData.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation
import StanwoodCore

struct AddedItem {
    let type: DebuggerFilterView.DebuggerFilter
    let count: Int
}

class DebuggerData {
    
    var analyticsItems: AnalyticItems
    var count = 98
    
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
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (_) in
            let item = AddedItem(type: .analytics, count: self.count)
            self.count += 1
            let not = Notification(name: Notification.Name.DeuggerDidAddDebuggerItem, object: item, userInfo: nil)
            NotificationCenter.default.post(not)
        }
    }
    
    func tempSetItems() {
        self.analyticsItems = try! JSONDecoder().decode(AnalyticItems.self, from: analytics_data)
    }

    @objc func didReceiveAnalyticsItem(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
        let data = try? JSONSerialization.data(withJSONObject: userInfo, options: []),
       let item = try? JSONDecoder().decode(DebuggerAnalyticsItem.self, from: data)  else { return }
        
        analyticsItems.append(item)
        
        let addedIem = AddedItem(type: .analytics, count: analyticsItems.numberOfItems)
        
        NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidAddDebuggerItem, object: addedIem)
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
