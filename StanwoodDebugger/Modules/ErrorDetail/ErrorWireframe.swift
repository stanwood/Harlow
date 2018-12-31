//
//  ErrorWireframe.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

class ErrorWireframe {

    static func makeViewController() -> ErrorViewController {
      return ErrorViewController()
    }

    static func prepare(_ viewController: ErrorViewController, with  actions: ErrorActionable, and parameters: ErrorParameterable) {
    	let presenter =  ErrorPresenter(actionable: actions, parameterable: parameters, viewable: viewController)
        viewController.presenter = presenter
    }

}
