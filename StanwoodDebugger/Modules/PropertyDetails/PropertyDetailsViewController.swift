//
//  PropertyDetailsViewController.swift
//  StanwoodDebugger
//
//  Created by AT on 7/15/19.
//

import UIKit
import SourceModel

class PropertyDetailsViewController: UIViewController, SourceTypePresentable {

    // MARK:- Properties

    var presenter: PropertyDetailsPresenter!
    var dataSource: PropertyDetailsDataSource!
    var delegate: PropertyDetailsDelegate!
    
    // MARK:- Outlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Typealias

    typealias DataSource = PropertyDetailsDataSource
    typealias Delegate = PropertyDetailsDelegate
    
    // MARK:- LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension PropertyDetailsViewController: PropertyDetailsViewable {
    
    func setupTableView(dataType: ModelCollection?) {
        
        delegate = PropertyDetailsDelegate(modelCollection: dataType)
        dataSource = PropertyDetailsDataSource(modelCollection: dataType)

        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
