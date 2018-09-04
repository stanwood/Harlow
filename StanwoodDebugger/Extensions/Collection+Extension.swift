//
//  Collection+Extension.swift
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

extension UICollectionView {
    
    func dequeue<Elemenet: UICollectionViewCell>(cellType: Elemenet.Type, for indexPath: IndexPath) -> Elemenet {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? Elemenet else {
            fatalError("Cell must exist")
        }
        return cell
    }
    func register(cell: UICollectionViewCell.Type, bundle: Bundle) {
        let nib = UINib(nibName: cell.identifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func register(cells: UICollectionViewCell.Type...) {
        cells.forEach { cell in
            let nib = UINib(nibName: cell.identifier, bundle: Bundle.debuggerBundle(from: type(of: self)))
            register(nib, forCellWithReuseIdentifier: cell.identifier)
        }
    }
    
    static var identifier: String {
        return String(describing: type(of: self))
    }
}

extension UITableView {
    
    func dequeue<Elemenet: UITableViewCell>(cellType: Elemenet.Type, for indexPath: IndexPath) -> Elemenet {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.staticIdentifier, for: indexPath) as? Elemenet else {
            fatalError("Cell must exist")
        }
        return cell
    }
    func register(cell: UITableViewCell.Type, bundle: Bundle) {
        let nib = UINib(nibName: cell.identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func register(cells: UITableViewCell.Type...) {
        cells.forEach { cell in
            let nib = UINib(nibName: cell.identifier, bundle: Bundle.debuggerBundle(from: type(of: self)))
            register(nib, forCellReuseIdentifier: cell.identifier)
        }
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
