//
//  NetworkingWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

class NetworkingWireframe {

    static func makeViewController() -> NetworkingViewController {
      return NetworkingViewController()
    }

    static func prepare(_ viewController: NetworkingViewController, with  actions: NetworkingActionable, and parameters: NetworkingParameterable) {
    	let presenter =  NetworkingPresenter(actionable: actions, parameterable: parameters, viewable: viewController)
        viewController.presenter = presenter
    }

}
