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
    
    private weak var button: DebuggerUIButton!
    
    init(frame: CGRect, button: DebuggerUIButton) {
        super.init(frame: frame)
        self.button = button
        backgroundColor = .white
        alpha = 0
//        prepare()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
//    private func prepare() {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        let close = UIButton()
//        let image = UIImage(named: "close_icon", in: Bundle(for: type(of: self)), compatibleWith: nil)
//        close.setImage(image, for: .normal)
//        close.translatesAutoresizingMaskIntoConstraints = false
//
//        let view = UIView()
//        view.backgroundColor = .red
//        view.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(close)
//
//        addSubview(view)
//
//        NSLayoutConstraint.activate([
//                view.heightAnchor.constraint(equalToConstant: 50),
//                view.topAnchor.constraint(equalTo: topAnchor),
//                view.leadingAnchor.constraint(equalTo: leadingAnchor),
//                view.trailingAnchor.constraint(equalTo: trailingAnchor)//,
////
////                close.heightAnchor.constraint(equalToConstant: 44),
////                close.widthAnchor.constraint(equalToConstant: 44),
////                close.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  -8),
////                close.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
//    }
    
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
