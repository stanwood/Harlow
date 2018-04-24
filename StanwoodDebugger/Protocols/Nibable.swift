//
//  Nibable.swift
//  StanwoodDebugger-StanwoodDebugger
//
//  Created by Tal Zion on 24/04/2018.
//

import Foundation

protocol Nibable { }

extension UIView: Nibable { }

extension Nibable where Self: UIView {
    
    static func loadFromNib(withFrame frame: CGRect? = nil, bundle: Bundle = Bundle.main) -> Self? {
        guard let view = bundle.loadNibNamed(staticIdentifier, owner: nil, options: nil)?.last as? Self else { return nil }
        view.frame = frame ?? view.frame
        return view
    }

    static var staticIdentifier: String {
        return String(describing: self)
    }
}
