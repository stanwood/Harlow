//
//  Loading.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public protocol Loading { }

extension UIView: Loading { }

extension Loading where Self: UIView {
    
    public static func loadFromNib(withFrame frame: CGRect? = nil, bundle: Bundle = Bundle.main) -> Self? {
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
    public func loadFromOutlet<T: UIView>(bundle: Bundle = Bundle.main) -> T? {
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
