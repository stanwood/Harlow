//
//  ExampleViewController.swift
//  StanwoodDebugger_Example
//
//  Created by Tal Zion on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import StanwoodCore


struct AnalyticExample: Typeable, Codable {
    
    let eventName: String
    let screenName: String?
    
    let itemId: String?
    let category: String?
    let contentType: String?
    
    var type: AnalyticsType {
        return screenName != nil ? .screen : AnalyticsType.type(forCount: [itemId, category, contentType].compactMap({$0}).count)
    }
    
    enum AnalyticsType {
        case screen, contentLong, contentShort, contentMedium
        
        var title: String {
            switch self {
            case .screen: return "Analytics screen event"
            case .contentShort: return "Analytics short event"
            case .contentMedium: return "Analytics medium event"
            case .contentLong: return "Analytics long event"
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
    
    private func payload() -> [String:String] {
        
        var payload: [String:String] = ["eventName": eventName]
        
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
  
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        payload["createdAt"] = dateFormatter.string(from: Date())
        
        return payload
    }
    
    func post() {
        let notificationCentre = NotificationCenter.default
        let notification = Notification.init(name: Notification.Name(rawValue: "io.stanwood.debugger.didReceiveAnalyticsItem"), object: nil, userInfo: payload())
        notificationCentre.post(notification)
    }
}

class AnalyticsExample: Stanwood.Elements<AnalyticExample>, Headerable {
    
    var headerView: UIView {
        let view = HeaderView.loadFromNib()
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "Analytics Example")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return AnalyticsExampleCell.self
    }
}

struct NetworkExample: Typeable, Codable {
    let method: NetworkingManager.Method
    let url: String
}

class NetworkingExample: Stanwood.Elements<NetworkExample>, Headerable {
    
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


class ExampleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ExampleDataSource!
    var delegate: ExampleDelegate!
    var sections: Stanwood.Sections!
    
    let getNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "https://httpbin.org/status/400"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/404"),
        NetworkExample(method: .get, url: "https://httpbin.org/headers"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/410"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/202"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/500"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/300"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/100"),
        NetworkExample(method: .get, url: "https://httpbin.org/image/jpeg")
    ]
    
    let responseFormatItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "https://httpbin.org/json"),
        NetworkExample(method: .get, url: "https://httpbin.org/html"),
        NetworkExample(method: .get, url: "https://httpbin.org/xml"),
        NetworkExample(method: .get, url: "https://httpbin.org/robots.txt"),
        NetworkExample(method: .get, url: "https://httpbin.org/deny")
    ]
    
    let postNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .post, url: "https://httpbin.org/post")
    ]
    
    let analyticsItems: [AnalyticExample] = [
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: "09873rf", category: "articles", contentType: "website"),
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: "asdf987", category: "foood", contentType: nil),
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: "cnaiodnc", category: nil, contentType: "product"),
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: nil, category: nil, contentType: nil),
        AnalyticExample(eventName: "", screenName: "home_view", itemId: nil, category: nil, contentType: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let responseFormatsExamples = NetworkingExample(items: responseFormatItems)
        responseFormatsExamples.title = "[GET] Response Formats Examples"
        let getNetworkingExamples = NetworkingExample(items: getNetworkingItems)
        getNetworkingExamples.title = "[GET] Networking Examples"
        let postNetworkingExamples = NetworkingExample(items: postNetworkingItems)
        postNetworkingExamples.title = "[POST] Networking Examples"

        
        let analyticsExamples = AnalyticsExample(items: analyticsItems)
        
        sections = Stanwood.Sections(items: [responseFormatsExamples, getNetworkingExamples, postNetworkingExamples, analyticsExamples])
        
        tableView.register(cellTypes: AnalyticsExampleCell.self, NetworkingExampleCell.self)
        
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderView")
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        dataSource = ExampleDataSource(dataType: sections)
        delegate = ExampleDelegate(dataType: sections)
        
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
}
