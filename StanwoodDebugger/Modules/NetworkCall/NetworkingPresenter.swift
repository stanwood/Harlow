//
//  NetworkingPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import StanwoodCore

protocol NetworkingViewable: class {
    func setupTableView(dataType: DataType?)
}

class NetworkingPresenter: Presentable {
    
    // MARK:- Properties
    
    unowned var viewable: NetworkingViewable
    var actionable: NetworkingActionable
    var parameterable: NetworkingParameterable
    
    // MARK:- Typealias
    
    typealias Actionable = NetworkingActionable
    typealias Parameterable = NetworkingParameterable
    typealias Viewable = NetworkingViewable
    
    // MARK:- Initialiser
    
    required init(actionable: NetworkingActionable, parameterable: NetworkingParameterable, viewable: NetworkingViewable) {
        self.viewable = viewable
        self.actionable = actionable
        self.parameterable = parameterable
    }
    
    // MARK:- Functions
    
    func viewDidLoad() {
        viewable.setupTableView(dataType: parameterable.items)
    }
}
