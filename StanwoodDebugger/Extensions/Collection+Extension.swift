//
//  Collection+Extension.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/04/2018.
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

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
