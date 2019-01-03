//
//  DebuggerData.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import StanwoodCore

struct AddedItem {
    let type: DebuggerFilterView.DebuggerFilter
    let count: Int
}

class DebuggerData {
    
    var analyticsItems: AnalyticItems
    var networkingItems: NetworkItems
    var logItems: LogItems
    var crashItems: CrashItems
    var errorItems: ErrorItems
    
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
    
    init() {
        if let items = try? Stanwood.Storage.retrieve(AnalyticItems.fileName, of: .json, from: .documents, as: AnalyticItems.self) {
            analyticsItems = items ?? AnalyticItems(items: [])
        } else {
            analyticsItems = AnalyticItems(items: [])
        }
        
        if let items = try? Stanwood.Storage.retrieve(NetworkItems.fileName, of: .json, from: .documents, as: NetworkItems.self) {
            networkingItems = items ?? NetworkItems(items: [])
        } else {
            networkingItems = NetworkItems(items: [])
        }
        
        if let items = try? Stanwood.Storage.retrieve(LogItems.fileName, of: .json, from: .documents, as: LogItems.self) {
            logItems = items ?? LogItems(items: [])
        } else {
            logItems = LogItems(items: [])
        }
        
        if let items = try? Stanwood.Storage.retrieve(ErrorItems.fileName, of: .json, from: .documents, as: ErrorItems.self) {
            errorItems = items ?? ErrorItems(items: [])
        } else {
            errorItems = ErrorItems(items: [])
        }
        
        if let items = try? Stanwood.Storage.retrieve(CrashItems.fileName, of: .json, from: .documents, as: CrashItems.self) {
            crashItems = items ?? CrashItems(items: [])
        } else {
            crashItems = CrashItems(items: [])
        }
        
        NotificationCenter.default.addObservers(self, observers:
            Stanwood.Observer(selector: #selector(didReceiveAnalyticsItem(_:)), name: .DebuggerDidReceiveAnalyticsItem),
                                                Stanwood.Observer(selector: #selector(didReceiveLogItem(_:)), name: .DeuggerDidReceiveLogItem),
                                                Stanwood.Observer(selector: #selector(save), name: UIApplication.willTerminateNotification),
                                                Stanwood.Observer(selector: #selector(didReceiveErrorItem(_:)), name: .DeuggerDidReceiveErrorItem),
                                                Stanwood.Observer(selector: #selector(didReceiveCrashItem(_:)), name: .DeuggerDidReceiveCrashItem),
                                                Stanwood.Observer(selector: #selector(didReceiveNetworkingItem(_:)), name: .DeuggerDidReceiveNetworkingItem)
        )
    }
    
    func removeAll() {
        /// Remove all stored items
        analyticsItems.removeAll()
        networkingItems.removeAll()
    }
    
    func refresh(withDelay delay: DispatchTimeInterval = .milliseconds(500)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let addedItems: [AddedItem] = [
                AddedItem(type: .analytics, count: self.analyticsItems.numberOfItems),
                AddedItem(type: .networking(item: nil), count: self.networkingItems.numberOfItems),
                AddedItem(type: .logs, count: self.logItems.numberOfItems),
                AddedItem(type: .error(item: nil), count: self.errorItems.numberOfItems),
                AddedItem(type: .crashes(item: nil), count: self.crashItems.numberOfItems)
            ]
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedItems)
        }
    }
    
    // MARK: - Analytics
    
    @objc func didReceiveAnalyticsItem(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let data = try? JSONSerialization.data(withJSONObject: userInfo, options: []),
            let item = try? decoder.decode(AnalyticsItem.self, from: data) else { return }
        
        
        analyticsItems.append(item)
        
        analyticsItems.items.sort(by: { ($0.createdAt ?? Date()) < ($1.createdAt ?? Date()) })
        
        let addedIems: [AddedItem] = [AddedItem(type: .analytics, count: analyticsItems.numberOfItems)]
        
        NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
    }
    
    @objc func didReceiveErrorItem(_ notification: Notification) {
        guard let item = notification.object as? ErrorItem else { assert(false); return }
        
        errorItems.append(item)
        errorItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .error(item: nil), count: errorItems.numberOfItems)]
        
        main {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendErrorItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveNetworkingItem(_ notification: Notification) {
        guard let item = notification.object as? NetworkItem else { assert(false); return }
        
        networkingItems.append(item)
        networkingItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .networking(item: nil), count: networkingItems.numberOfItems)]
        
        main {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveLogItem(_ notification: Notification) {
        guard let item = notification.object as? LogItem else { assert(false); return }
        
        logItems.append(item)
        logItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .logs, count: logItems.numberOfItems)]
        
        main {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendLogItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveCrashItem(_ notification: Notification) {
        guard let item = notification.object as? CrashItem else { assert(false); return }
        
        crashItems.append(item)
        crashItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .crashes(item: nil), count: crashItems.numberOfItems)]
        try? Stanwood.Storage.store(crashItems, to: .documents, as: .json, withName: CrashItems.fileName)

        main {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendCrashItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func save() {
        if DebuggerSettings.shouldStoreLogsData {
            try? Stanwood.Storage.store(logItems, to: .documents, as: .json, withName: LogItems.fileName)
        }
        
        if DebuggerSettings.shouldStoreAnalyticsData {
            try? Stanwood.Storage.store(analyticsItems, to: .documents, as: .json, withName: AnalyticItems.fileName)
        }
        
        if DebuggerSettings.shouldStoreErrorData {
            try? Stanwood.Storage.store(errorItems, to: .documents, as: .json, withName: ErrorItems.fileName)
        }
        
        if DebuggerSettings.shouldStoreNetworkingData {
            try? Stanwood.Storage.store(networkingItems, to: .documents, as: .json, withName: NetworkItems.fileName)
        }

        try? Stanwood.Storage.store(crashItems, to: .documents, as: .json, withName: CrashItems.fileName)

        refresh()
    }
}
