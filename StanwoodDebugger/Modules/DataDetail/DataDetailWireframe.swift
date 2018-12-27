//
//  DataDetailWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

class DataDetailWireframe {
    
    static func makeViewController() -> DataDetailViewController {
        return DataDetailViewController()
    }
    
    static func prepare(_ viewController: DataDetailViewController, with  actions: DataDetailActionable, and parameters: DataDetailParameterable) {
        let presenter =  DataDetailPresenter(actionable: actions, parameterable: parameters, viewable: viewController)
        viewController.presenter = presenter
    }
}
