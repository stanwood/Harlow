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
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    var counter: Int = 0
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
        
        
        /// MOCK DATA
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (_) in
            
            guard self.counter < 4 else { return }
            self.counter += 1

            let dateString = self.formatter.string(from: Date())
            let dic: [String: Any] = [
                "createdAt" : dateString,
                "eventName" : "stanwood 2018",
                "itemId" : "we_work",
                "contentType" : "beer",
                "category" : "burgers"
            ]
            
            
            let not = Notification(name: Notification.Name.DebuggerDidReceiveAnalyticsItem, object: nil, userInfo: dic)
            NotificationCenter.default.post(not)
        }
    }
    
    func removeAll() {
        /// Remove all stored items
        analyticsItems.removeAll()
    }
    
    func refresh(withDelay delay: DispatchTimeInterval = .milliseconds(500)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let addedIems: [AddedItem] = [AddedItem(type: .analytics, count: self.analyticsItems.numberOfItems)]
            NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveAnalyticsItem(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let data = try? JSONSerialization.data(withJSONObject: userInfo, options: []),
            let item = try? decoder.decode(AnalyticsItem.self, from: data)  else { return }
        
        
        analyticsItems.append(item)
        
        analyticsItems.items.sort(by: { ($0.createdAt ?? Date()) > ($1.createdAt ?? Date()) })
        
        let addedIems: [AddedItem] = [AddedItem(type: .analytics, count: analyticsItems.numberOfItems)]
        
        NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidAddDebuggerItem, object: addedIems)
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
        
        refresh()
    }
}
