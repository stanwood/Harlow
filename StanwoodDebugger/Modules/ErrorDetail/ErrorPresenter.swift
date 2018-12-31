//
//  ErrorPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import StanwoodCore

protocol ErrorViewable: class {
    func setupTableView(dataType: DataType?)
}

class ErrorPresenter: Presentable {
    
    // MARK:- Properties
    
    unowned var viewable: ErrorViewable
    var actionable: ErrorActionable
    var parameterable: ErrorParameterable
    
    // MARK:- Typealias
    
    typealias Actionable = ErrorActionable
    typealias Parameterable = ErrorParameterable
    typealias Viewable = ErrorViewable
    
    // MARK:- Initialiser
    
    required init(actionable: ErrorActionable, parameterable: ErrorParameterable, viewable: ErrorViewable) {
        self.viewable = viewable
        self.actionable = actionable
        self.parameterable = parameterable
    }
    
    // MARK:- Functions
    
    func viewDidLoad() {
        viewable.setupTableView(dataType: parameterable.sections)
    }
}
