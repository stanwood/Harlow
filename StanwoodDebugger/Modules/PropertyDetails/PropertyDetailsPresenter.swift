//
//  PropertyDetailsPresenter.swift
//  StanwoodDebugger
//
//  Created by AT on 7/15/19.
//

import StanwoodCore
import SourceModel

protocol PropertyDetailsViewable: class {
    func setupTableView(dataType: ModelCollection?)
}

class PropertyDetailsPresenter: Presentable {
    
    // MARK:- Properties
    
    weak var view: PropertyDetailsViewable?
    var actions: PropertyDetailsActionable
    var parameters: PropertyDetailsParameterable
    
    // MARK:- Typealias
    
    typealias Actionable = PropertyDetailsActionable
    typealias Parameterable = PropertyDetailsParameterable
    typealias Viewable = PropertyDetailsViewable
    
    // MARK:- Initialiser
    
    required init(actions: PropertyDetailsActionable, parameters: PropertyDetailsParameterable, view: PropertyDetailsViewable) {
        self.view = view
        self.actions = actions
        self.parameters = parameters
    }
    
    // MARK:- Functions
    
    func viewDidLoad() {
        view?.setupTableView(dataType: parameters.collection)
    }
}
