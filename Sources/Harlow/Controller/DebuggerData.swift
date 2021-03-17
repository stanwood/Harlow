//
//  DebuggerData.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.io)
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
import UIKit
import SourceModel

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
    var isDebuggingDataPersistenceEneabled: Bool = false
    
    private var operations: OperationQueue = OperationQueue()
    
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
        
        operations.isSuspended = false
        operations.maxConcurrentOperationCount = 1
        
        if let items = try? Storage.retrieve(AnalyticItems.fileName, of: .json, from: .documents(customDirectory: nil), as: AnalyticItems.self) {
            analyticsItems = items
        } else {
            analyticsItems = AnalyticItems(items: [])
        }
        
        if let items = try? Storage.retrieve(NetworkItems.fileName, of: .json, from: .documents(customDirectory: nil), as: NetworkItems.self) {
            networkingItems = items
        } else {
            networkingItems = NetworkItems(items: [])
        }
        
        if let items = try? Storage.retrieve(LogItems.fileName, of: .json, from: .documents(customDirectory: nil), as: LogItems.self) {
            logItems = items
        } else {
            logItems = LogItems(items: [])
        }
        
        if let items = try? Storage.retrieve(ErrorItems.fileName, of: .json, from: .documents(customDirectory: nil), as: ErrorItems.self) {
            errorItems = items
        } else {
            errorItems = ErrorItems(items: [])
        }
        
        if let items = try? Storage.retrieve(CrashItems.fileName, of: .json, from: .documents(customDirectory: nil), as: CrashItems.self) {
            crashItems = items
        } else {
            crashItems = CrashItems(items: [])
        }
        
        NotificationCenter.default.addObservers(self, observers:
            Observer(selector: #selector(didReceiveAnalyticsItem(_:)), name: .DebuggerDidReceiveAnalyticsItem),
                                                Observer(selector: #selector(didReceiveLogItem(_:)), name: .DeuggerDidReceiveLogItem),
                                                Observer(selector: #selector(save), name: UIApplication.willTerminateNotification),
                                                Observer(selector: #selector(didReceiveErrorItem(_:)), name: .DeuggerDidReceiveErrorItem),
                                                Observer(selector: #selector(didReceiveCrashItem(_:)), name: .DeuggerDidReceiveCrashItem),
                                                Observer(selector: #selector(didReceiveNetworkingItem(_:)), name: .DeuggerDidReceiveNetworkingItem)
        )
    }
    
    func removeAll() {
        analyticsItems.removeAll()
        networkingItems.removeAll()
        logItems.removeAll()
        errorItems.removeAll()
        crashItems.removeAll()
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
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveErrorItem(_ notification: Notification) {
        guard let item = notification.object as? ErrorItem else { assert(false); return }
        
        let operation = BlockOperation {
            [weak self] in
            guard let self = self else { return }
            self.errorItems.append(item)
            self.errorItems.move(item, to: 0)
        }
        
        operations.addOperation(operation)
        
        let addedIems: [AddedItem] = [AddedItem(type: .error(item: nil), count: errorItems.numberOfItems)]
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendErrorItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveNetworkingItem(_ notification: Notification) {
        guard let item = notification.object as? NetworkItem else { assert(false); return }
        
        networkingItems.append(item)
        networkingItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .networking(item: nil), count: networkingItems.numberOfItems)]
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendAnalyticsItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveLogItem(_ notification: Notification) {
        guard let item = notification.object as? LogItem else { assert(false); return }
        
        logItems.append(item)
        logItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .logs, count: logItems.numberOfItems)]
    
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendLogItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func didReceiveCrashItem(_ notification: Notification) {
        guard let item = notification.object as? CrashItem else { assert(false); return }
        
        crashItems.append(item)
        crashItems.move(item, to: 0)
        
        let addedIems: [AddedItem] = [AddedItem(type: .crashes(item: nil), count: crashItems.numberOfItems)]
        store(type: .crashes)
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAppendCrashItem, object: nil)
            NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: addedIems)
        }
    }
    
    @objc func save() {
        for type in DebuggerIconLabel.DebuggerIcons.allCases {
            self.store(type: type)
        }
    }
    
    func store(type: DebuggerIconLabel.DebuggerIcons) {
        guard isDebuggingDataPersistenceEneabled else { return }
        
        switch type {
        case .analytics:
            if DebuggerSettings.shouldStoreAnalyticsData {
                try? Storage.store(analyticsItems, to: .documents(customDirectory: nil), as: .json, withName: AnalyticItems.fileName)
            }
        case .logs:
            if DebuggerSettings.shouldStoreLogsData {
                try? Storage.store(logItems, to: .documents(customDirectory: nil), as: .json, withName: LogItems.fileName)
            }
        case .crashes:
            if DebuggerSettings.shouldStoreCrashesData {
                try? Storage.store(crashItems, to: .documents(customDirectory: nil), as: .json, withName: CrashItems.fileName)
            }

        case .error:
            if DebuggerSettings.shouldStoreErrorData {
                try? Storage.store(errorItems, to: .documents(customDirectory: nil), as: .json, withName: ErrorItems.fileName)
            }
        case .networking:
            if DebuggerSettings.shouldStoreNetworkingData {
                try? Storage.store(networkingItems, to: .documents(customDirectory: nil), as: .json, withName: NetworkItems.fileName)
            }
        }
    }
}
