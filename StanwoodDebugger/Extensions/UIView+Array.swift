//
//  UIButton+Array.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/04/2018.
//

import Foundation

extension Array where Element: UIView {
    
    func hide(animated: Bool = true, duration: TimeInterval = 0.5) {
        if animated {
            UIView.animate(withDuration: duration) {
                self.forEach({ $0.alpha = 0 })
            }
        } else {
            self.forEach({ $0.alpha = 0 })
        }
    }
    
    func show(animated: Bool = true, duration: TimeInterval = 0.5) {
        if animated {
            UIView.animate(withDuration: duration) {
                self.forEach({ $0.alpha = 1 })
            }
        } else {
            self.forEach({ $0.alpha = 1 })
        }
    }
}
