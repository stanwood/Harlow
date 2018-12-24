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
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.8)
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
    
    var headerView: UIView {
        let view = HeaderView.loadFromNib()
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view?.set(title: "Networking Example")
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
    
    let networkingItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "http://httpbin.org/status/400"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/401"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/402"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/403"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/404"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/405"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/406"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/407"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/408"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/409"),
        NetworkExample(method: .get, url: "http://httpbin.org/status/410")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkingExamples = NetworkingExample(items: networkingItems)
        let analyticsExamples = AnalyticsExample(items: [AnalyticExample()])
        
        sections = Stanwood.Sections(items: [networkingExamples, analyticsExamples])
        
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
