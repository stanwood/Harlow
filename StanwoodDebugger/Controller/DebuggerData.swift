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
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    init() {
        if let items = try? Stanwood.Storage.retrieve(AnalyticItems.fileName, of: .json, from: .documents, as: AnalyticItems.self) {
            analyticsItems = items ?? AnalyticItems(items: [])
        } else {
            analyticsItems = AnalyticItems(items: [])
        }
        
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
        self.analyticsItems = try! decoder.decode(AnalyticItems.self, from: analytics_data)
    }
    
    @objc func didReceiveAnalyticsItem(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let data = try? JSONSerialization.data(withJSONObject: userInfo, options: []),
            let item = try? decoder.decode(AnalyticsItem.self, from: data)  else { return }
        
        
        analyticsItems.append(item)
        
        let addedIem = AddedItem(type: .analytics, count: analyticsItems.numberOfItems)
        
        NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidAddDebuggerItem, object: addedIem)
    }
    
    @objc func didReceiveErrorItem(_ notification: Notification) {
        // SFW-52: Phase 3
    }
    
    @objc func didReceiveNetworkingItem(_ notification: Notification) {
        // SFW-54: Phase 5
    }
    
    @objc func didReceiveLogItem(_ notification: Notification) {
        // SFW-55: Phase 6
    }
    
    @objc func didReceiveUITestingItem(_ notification: Notification) {
        // SFW-53: Phase 4
    }
    
    func save() {
        if DebuggerSettings.shouldStoreAnalyticsData {
            try? Stanwood.Storage.store(analyticsItems, to: .documents, as: .json, withName: AnalyticItems.fileName)
        }
    }
}

// MOCK DATA

let analytics_data: Data = """
{
"items" : [
{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"contentType" : "some_content_type",
"category" : "meals"
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"contentType" : "some_content_type",
"category" : "meals"
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"contentType" : "some_content_type",
"category" : "meals"
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"category" : "meals"
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"contentType" : "some_content_type",
},{
"eventName" : "user_action",
"itemId" : "123",
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"contentType" : "some_content_type",
"category" : "meals"
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"itemId" : "123",
"contentType" : "some_content_type",
"category" : "meals"
},{
"createdAt": "2018-08-01T05:00:02+0300",
"eventName" : "user_action",
"contentType" : "some_content_type",
"category" : "meals"
}
]
}
""".data(using: .utf8)!

