//
//  Autosizable.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2020 Stanwood GmbH (www.stanwood.io)
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

import Foundation
import UIKit

/*
 if let flowLayout = viewController.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
 flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
 }
 */

///
/// Protocol auto size the cell to the device width
/// Note: collectionView.collectionViewLayout estimatedItemSize should equal to UICollectionViewFlowLayoutAutomaticSize
///
/// **available** iOS 10 and above
/// Note> Only supports portraite atm. Landscape is still in R&D
///
@available(iOS 10.0, *)
protocol AutoSizeable {
    var widthConstraint: NSLayoutConstraint? { get set }
    func autoSize() -> NSLayoutConstraint?
}

@available(iOS 10.0, *)
extension AutoSizeable where Self: UICollectionViewCell {
    
    /// Call when device rotates
    @discardableResult
    func autoSize() -> NSLayoutConstraint? {
        
        guard self.widthConstraint == nil else {
            self.widthConstraint?.constant = UIScreen.main.bounds.width
            updateConstraintsIfNeeded()
            return self.widthConstraint
        }
        
        let widthConstraint = contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        NSLayoutConstraint.activate([ widthConstraint ])
        
        return widthConstraint
    }
}

/// Inherit AutoSizeableCell to conform to Autosizable protocol
@available(iOS 10.0, *)
class AutoSizeableCell: UICollectionViewCell, AutoSizeable {
    
    // MARK: Properties
    
    /// Support for device rotation
    public var widthConstraint: NSLayoutConstraint?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint = autoSize()
    }
}
