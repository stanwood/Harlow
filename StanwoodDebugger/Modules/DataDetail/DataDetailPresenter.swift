//
//  DataDetailPresenter.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

import StanwoodCore

protocol DataDetailViewable: class {
    var navigationBarTitle: String? { get set }
    func show(_ networkData: NetworkData)
}

class DataDetailPresenter: Presentable {
    
    // MARK:- Properties
    
    unowned var viewable: DataDetailViewable
    var actionable: DataDetailActionable
    var parameterable: DataDetailParameterable
    
    // MARK:- Typealias
    
    typealias Actionable = DataDetailActionable
    typealias Parameterable = DataDetailParameterable
    typealias Viewable = DataDetailViewable
    
    
    required init(actionable: DataDetailActionable, parameterable: DataDetailParameterable, viewable: DataDetailViewable) {
        self.viewable = viewable
        self.actionable = actionable
        self.parameterable = parameterable
    }
    
    func viewDidLoad() {
        viewable.navigationBarTitle = parameterable.networkData.data.prettyString
        viewable.show(parameterable.networkData)
    }
}
