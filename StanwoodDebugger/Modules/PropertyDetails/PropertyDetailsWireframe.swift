//
//  PropertyDetailsWireframe.swift
//  StanwoodDebugger
//
//  Created by AT on 7/15/19.
//

class PropertyDetailsWireframe {

    static func makeViewController() -> PropertyDetailsViewController {
      return UIStoryboard(name: PropertyDetailsViewController.self.identifier, bundle: nil).instantiate(viewController: PropertyDetailsViewController.self)
    }

    static func prepare(_ viewController: PropertyDetailsViewController, with  actions: PropertyDetailsActionable, and parameters: PropertyDetailsParameterable) {
    	let presenter =  PropertyDetailsPresenter(actions: actions, parameters: parameters, view: viewController)
        viewController.presenter = presenter
    }

}
