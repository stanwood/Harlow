//
//  Loading.swift
//  StanwoodDebugger-StanwoodDebugger
//
//  Created by Tal Zion on 24/04/2018.
//

import Foundation

protocol Loading { }

extension UIView: Loading { }

extension Loading where Self: UIView {
    
    static func loadFromNib(withFrame frame: CGRect? = nil, bundle: Bundle = Bundle.main) -> Self? {
        guard let view = bundle.loadNibNamed(staticIdentifier, owner: nil, options: nil)?.last as? Self else { return nil }
        view.frame = frame ?? view.frame
        return view
    }
    /**
     load `UIView` from outlet
     
     - Parameters:
     - bundle: default = Bundle.main
     */
    @discardableResult
    func loadFromOutlet<T: UIView>(bundle: Bundle = Bundle.main) -> T? {
        guard let view = bundle.loadNibNamed(identifier, owner: self, options: nil)?.first as? T else { return nil }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(from: self)
        return view
    }
    
    var identifier: String {
        return String(describing: type(of: self))
    }
    
    static var staticIdentifier: String {
        return String(describing: self)
    }
    
    func addConstraints(from view: UIView, top: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}
