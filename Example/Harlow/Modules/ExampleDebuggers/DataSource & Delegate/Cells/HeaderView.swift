//
//  HeaderView.swift
//  Harlow_Example
//
//  Created by Tal Zion on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
        titleLabel.textColor = .black
    }

    private func clear() {
        titleLabel?.text = nil
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
}
