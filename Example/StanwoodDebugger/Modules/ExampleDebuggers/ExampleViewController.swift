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

class ExampleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ExampleDataSource!
    var delegate: ExampleDelegate!
    var sections: Stanwood.Sections!
    
    enum ExampleType: Int {
        case http, analytics, error, logs, uiTesting
    }
    
    var exampleType: ExampleType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exampleType = ExampleType(rawValue: tabBarController!.selectedIndex)!
        
        main(deadline: .seconds(3)) {
            let err = NSError(domain: "com.debugger.test", code: -1, userInfo: [:])
        }
        
        print(" Testting Debugger Logs ")
        debugPrint(" Testting Debugger Logs ")
        
        switch exampleType! {
        case .http:
            
            let responseFormatsExamples = NetworkingExample(items: ModelItems.responseFormatItems)
            responseFormatsExamples.title = "Response Formats"
            let getImgesNetworkingExample = NetworkingExample(items: ModelItems.getImgesNetworkingItems)
            getImgesNetworkingExample.title = "Image Formats"
            let getNetworkingExamples = NetworkingExample(items: ModelItems.getNetworkingItems)
            getNetworkingExamples.title = "[GET] Calls"
            let postNetworkingExamples = NetworkingExample(items: ModelItems.postNetworkingItems)
            postNetworkingExamples.title = "[POST] Calls"
            
            sections = Stanwood.Sections(items: [responseFormatsExamples, getImgesNetworkingExample, getNetworkingExamples, postNetworkingExamples])
        case .analytics:
            
            let analyticsContentExamples = AnalyticsExample(items: ModelItems.analyticsContentItems)
            analyticsContentExamples.title = "Content Tracking"
            let analyticsScreenExamples = AnalyticsExample(items: ModelItems.analyticsScreenItems)
            analyticsScreenExamples.title = "Screen Tracking"
            
            sections = Stanwood.Sections(items: [analyticsScreenExamples, analyticsContentExamples])
        default: break
        }
        
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
