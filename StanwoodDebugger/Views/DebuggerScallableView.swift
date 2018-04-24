//
//  DebuggerScallableView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 23/04/2018.
//

import Foundation

class DebuggerScallableView: UIView {
    
    private var size: CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize(width: screenSize.width - 18, height: screenSize.height / 1.8 )
    }
    
    weak var button: DebuggerUIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    func show() {
        center = button.center
        button.isPulseEnabled = false

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { _ in
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.frame = CGRect(origin: .zero, size: self.size)
                self.center = UIApplication.shared.keyWindow?.center ?? .zero
                self.alpha = 1
            }, completion: nil)
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.frame = CGRect(origin: .zero, size: .zero)
            self.center = self.button.center
            self.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.button.transform = .identity
                self.button.isPulseEnabled = true
            }, completion: nil)
        }
    }
}
