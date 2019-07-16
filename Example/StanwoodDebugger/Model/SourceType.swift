//
//  SourceType.swift
//  StanwoodDebugger_Example
//
//  Created by Tal Zion on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SourceModel

struct AnalyticExample: ActionItemable, Model, Codable, Equatable {
    
    let eventName: String
    let screenName: String?
    let itemId: String?
    let category: String?
    let contentType: String?
    let superProperty: PanelTypeWrapperItems?
    
    var type: AnalyticsType {
        return superProperty != nil ? .superProperty : (screenName != nil ? .screen : AnalyticsType.type(forCount: [itemId, category, contentType].compactMap({$0}).count))
    }
    
    enum AnalyticsType {
        case screen, contentLong, contentShort, contentMedium, superProperty
        
        var title: String {
            switch self {
            case .screen: return "Analytics screen event"
            case .contentShort: return "Analytics short event"
            case .contentMedium: return "Analytics medium event"
            case .contentLong: return "Analytics long event"
            case .superProperty: return "Super Property"
            }
        }
        
        static func type(forCount count: Int) -> AnalyticsType {
            switch count {
            case 1: return .contentShort
            case 2: return .contentMedium
            case 3: return .contentLong
            default: return .contentShort
            }
        }
    }
    
    private func payload() -> [String:Any] {
        
        var payload: [String:Any] = ["eventName": eventName]
        
        if let itemId = itemId {
            payload["itemId"] = itemId
        }
        
        if let category = category {
            payload["category"] = category
        }
        
        if let contentType = contentType {
            payload["contentType"] = contentType
        }
        
        if let screenName = screenName {
            payload["screenName"] = screenName
        }
        
        if let screenName = screenName {
            payload["screenName"] = screenName
        }
        
        if let superProperty = superProperty {
            payload["superProperty"] = "superProperty" // Crashing when using dictionary
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        payload["createdAt"] = dateFormatter.string(from: Date())
        
        return payload
    }
    
    func postAction() {
        let notificationCentre = NotificationCenter.default
        let notification = Notification.init(name: Notification.Name(rawValue: "io.stanwood.debugger.didReceiveAnalyticsItem"), object: nil, userInfo: payload())
        notificationCentre.post(notification)
    }
}

class AnalyticsExample: Elements<AnalyticExample>, Headerable {
    
    var title: String = ""
    
    var headerView: UIView {
        let view = HeaderView.loadFromNib()
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: title)
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return AnalyticsExampleCell.self
    }
}

struct NetworkExample: Model, Codable, Equatable {
    let method: NetworkingManager.Method
    let url: String
}

class NetworkingExample: Elements<NetworkExample>, Headerable {
    
    var title: String = ""
    
    var headerView: UIView {
        let view = HeaderView.loadFromNib()
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: title)
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkingExampleCell.self
    }
}

class CrashExample: NSObject, Model, Codable, ActionItemable {
    enum CrashType: Int, Codable {
        case crash, signal

        var displayName: String {
            switch self {
            case .crash:
                return "NSException"
            case .signal:
                return "Signal"
            }
        }
    }
    let type: CrashType

    init(type: CrashType) {
        self.type = type
    }

    func postAction() {
        switch type {
        case .crash:
            self.perform(Selector(("missingSelector")), with: nil, afterDelay: 0.0)
        case .signal:
            (self.type as! UIView)
        }
    }
}

class CrashesExample: Elements<CrashExample>, Headerable {

    var title: String = ""

    var headerView: UIView {
        let view = HeaderView.loadFromNib()
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: title)
        return view ?? UIView()
    }

    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return CrashSampleCell.self
    }
}

typealias Fillable = SourceModel.Fillable
typealias Delegateble = SourceModel.Delegateble
typealias Model = SourceModel.Model
typealias SourceTypePresentable = SourceModel.SourceTypePresentable
typealias DataSourceType = SourceModel.DataSourceType
typealias DelegateSourceType = SourceModel.DelegateSourceType
typealias Headerable = SourceModel.Headerable

