//
//  DebuggerUIButton.swift
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
//import Pulsator // Wait for Swift 4.2 support
import StanwoodCore

class DebuggerUIButton: UIButton {
    
    private enum Positions {
        case topLeft, topRight, centerLeft, centerRight, bottomLeft, bottomRight
        
        static var buttonSize: CGSize {
            return CGSize(width: 65, height: 65)
        }
        
        static func position(for point: CGPoint) -> Positions {
            if Positions.centerLeft.rect.contains(point) {
                return .centerLeft
            } else if Positions.centerRight.rect.contains(point) {
                return .centerRight
            } else if Positions.topLeft.rect.contains(point) {
                return .topLeft
            } else if Positions.topRight.rect.contains(point) {
                return .topRight
            } else if Positions.bottomLeft.rect.contains(point) {
                return .bottomLeft
            } else if Positions.bottomRight.rect.contains(point) {
                return .bottomRight
            } else {
                return .centerLeft
            }
        }
        
        var rect: CGRect {
            let screenSize = UIScreen.main.bounds.size
            let size = CGSize(width: screenSize.width / 2, height: screenSize.height / 3)
            
            switch self {
            case .topLeft:
                let origin = CGPoint(x: 0, y: 0)
                let rect = CGRect(origin: origin, size: size)
                return rect
            case .topRight:
                let origin = CGPoint(x: size.width, y: 0)
                let rect = CGRect(origin: origin, size: size)
                return rect
            case .centerLeft:
                let origin = CGPoint(x: 0, y: size.height)
                let rect = CGRect(origin: origin, size: size)
                return rect
            case .centerRight:
                let origin = CGPoint(x: size.width, y: size.height)
                let rect = CGRect(origin: origin, size: size)
                return rect
            case .bottomLeft:
                let origin = CGPoint(x: 0, y: size.height * 2)
                let rect = CGRect(origin: origin, size: size)
                return rect
            case .bottomRight:
                let origin = CGPoint(x: size.width, y: size.height * 2)
                let rect = CGRect(origin: origin, size: size)
                return rect
            }
        }
        
        var origin: CGPoint {
            let screenSize = UIScreen.main.bounds.size
            let leftX: CGFloat = screenSize.width - (10 + Positions.buttonSize.width / 2)
            let rightX: CGFloat = 10 + Positions.buttonSize.width / 2
            let topY: CGFloat = 70 + Positions.buttonSize.height / 2
            let bottomY: CGFloat = screenSize.height - (60 + Positions.buttonSize.height / 2)
            
            switch self {
            case .topLeft:
                return CGPoint(x: rightX, y: topY)
            case .topRight:
                return CGPoint(x: leftX, y: topY)
            case .centerLeft:
                return CGPoint(x: rightX, y: screenSize.height / 2)
            case .centerRight:
                return CGPoint(x: leftX, y: screenSize.height / 2)
            case .bottomLeft:
                return CGPoint(x: rightX, y: bottomY)
            case .bottomRight:
                return CGPoint(x: leftX, y: bottomY)
            }
        }
    }
    
//    private lazy var pulsator: Pulsator = Pulsator() // Wait for Swift 4.2 support
    
    var isPulseEnabled: Bool = false {
        didSet {
            switch isPulseEnabled {
            case true: break // pulsator.start()
            case false: break // pulsator.stop()
            }
        }
    }
    
    private let debugger: Debugging
    
    init(debugger: Debugging) {
        
        self.debugger = debugger
        
        super.init(frame: CGRect(origin: Positions.centerLeft.origin, size: Positions.buttonSize))
        center = Positions.centerLeft.origin
        
        layer.cornerRadius = Positions.buttonSize.width / 2
        
        let image = UIImage(named: "icon_virus", in: Bundle.debuggerBundle(), compatibleWith: nil)
        setImage(image, for: .normal)
        tintColor = .white
        setTitleColor(.white, for: .normal)
        backgroundColor = StanwoodDebugger.Style.tintColor
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panning(_:)))
        addGestureRecognizer(pan)
        
        NotificationCenter.default.addObservers(self, observers: Stanwood.Observer(selector: #selector(didAddDebuggerItem(_:)), name: Notification.Name.DeuggerDidAddDebuggerItem))
    }
    
    func preparePulse() {
        guard DebuggerSettings.isDebuggerBubblePulseAnimationEnabled else { return }
        /*
        pulsator.backgroundColor = StanwoodDebugger.Style.tintColor.cgColor
        pulsator.radius = Positions.buttonSize.width * 0.875
        pulsator.numPulse = 3
        pulsator.animationDuration = 3
        pulsator.position = center
        
        superview?.layer.insertSublayer(pulsator, below: layer)
         */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panning(_ pan: UIPanGestureRecognizer) {
        
        let translation = pan.translation(in: superview)
        pan.setTranslation(.zero, in: superview)
        
        var center = self.center
        center.x += translation.x
        center.y += translation.y
        self.center = center
//        pulsator.position = center
        
        switch pan.state {
        case .ended, .cancelled:
            let position = Positions.position(for: center)
//            pulsator.position = position.origin
            
            main {
                Stanwood.FeedbackGenerator.generate(style: .light)
            }
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                self.center = position.origin
                self.transform = .identity
            }, completion: { _ in
                
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
//                    self.pulsator.opacity = 1
                }, completion: nil)
            })
        case .began:
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//                self.pulsator.opacity = 0
            }, completion: nil)
        default: break
        }
    }
    
    @objc private func didAddDebuggerItem(_ notification: Notification) {
        guard let addedItems = notification.object as? [AddedItem] else { return }
        
        addedItems.forEach({
            
            switch $0.type {
            case .analytics:
                animate(.analytics)
            case .networking:
                animate(.networking)
            case .error, .logs, .uiTesting: break
            }
            
            
        })
    }
    
    private func animate(_ icon: DebuggerIconLabel.DebuggerIcons) {
        main(deadline: .milliseconds(500)) { [weak self] in
            guard let `self` = self else { return }
            
            // Generating vibration feedback
            Stanwood.FeedbackGenerator.generate(style: .light)
            
            // Animating the icon
            guard !self.debugger.isDisplayed, DebuggerSettings.isDebuggerItemIconsAnimationEnabled else { return }
            let label = DebuggerIconLabel(icon: icon,frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            label.center = CGPoint(x: self.center.x + 20, y: self.center.y)
            self.superview?.insertSubview(label, belowSubview: self)
            
            let point = CGPoint(x: self.center.x, y: self.center.y - 250)
            label.animate(to: point)
        }
    }
}
