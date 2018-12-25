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
    
}

class AnalyticsExample: Stanwood.Elements<AnalyticExample>, Headerable {
    
    var headerView: UIView {
        let view = HeaderView.loadFromNib()
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "Analytics Example")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return AnalyticsCell.self
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
        return NetworkingCell.self
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
        NetworkExample(method: .get, url: "https://httpbin.org/status/200"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/410"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/202"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/500"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/300"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/100")
    ]
    
    let postNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .post, url: "https://httpbin.org/post")
    ]
    
    let imageNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "https://httpbin.org/image/jpeg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getNetworkingExamples = NetworkingExample(items: getNetworkingItems)
        getNetworkingExamples.title = "[GET] Networking Examples"
        let postNetworkingExamples = NetworkingExample(items: postNetworkingItems)
        postNetworkingExamples.title = "[POST] Networking Examples"
        let imageNetworkingExamples = NetworkingExample(items: imageNetworkingItems)
        imageNetworkingExamples.title = "[IMAGE] Networking Examples"
        
        let analyticsExamples = AnalyticsExample(items: [AnalyticExample()])
        
        sections = Stanwood.Sections(items: [getNetworkingExamples, postNetworkingExamples, imageNetworkingExamples, analyticsExamples])
        
        tableView.register(cellTypes: AnalyticsCell.self, NetworkingCell.self)
        
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
