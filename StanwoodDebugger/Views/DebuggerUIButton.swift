//
//  DebuggerUIButton.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation
import Pulsator
import StanwoodCore

typealias AnimationCompletion = (UILabel) -> Void
typealias DoneCompletion = (Bool) -> Void

enum DebuggerIcons: String {
    case analytics = "👻"
    case error = "⚠️"
    case log = "✏️"
    case uiTesting = "📱"
    case networking = "📶"
    
    private var duration: TimeInterval {
        switch self {
        case .analytics:
            return 5
        case .error, .log, .networking, .uiTesting: return 0 // WIP
        }
    }
    
    func animate(_ label: UILabel, toPoint point: CGPoint, completion: @escaping AnimationCompletion){
        
        let completed: (Bool) -> Void = { [label = label] _ in
            completion(label)
        }
        
        switch self {
        case .analytics:
            
            let numberOfTurnPoints = 3
            let durationUntilChange = duration / Double(numberOfTurnPoints)
            
            /// Fade out
            UIView.animate(withDuration: duration / 2, delay: duration / 2, options: .curveEaseOut, animations: { [label = label] in
                label.alpha = 0
            }, completion: nil)
            
            /// Ghost kind animation
            for index in 0..<Int(numberOfTurnPoints) {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * durationUntilChange)) { [currentIndex = index, label = label] in
                    self.performAnimation(to: label, with: durationUntilChange, delay: 0, completion: currentIndex == (numberOfTurnPoints - 1) ? completed : nil)
                    
                }
            }
            
            /// Path animation
            let path = UIBezierPath()
            
            path.move(to: label.center)
            path.addLine(to: point)
            
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.cgPath
            anim.repeatCount = 0
            anim.duration = duration
            anim.isRemovedOnCompletion = true
            label.layer.add(anim, forKey: "animateLabel")
            
        case .error, .networking, .uiTesting, .log: break
        }
    }
    
    private func performAnimation(to label: UILabel, with duration: Double, delay: Double, completion: DoneCompletion?){
        
        UIView.animate(withDuration: duration, delay: delay, options: [.allowAnimatedContent], animations: {
            
            let isNegative = label.transform.tx < 0
            var newX = CGFloat.random(between: 50, and: 20)
            newX = isNegative ? newX : (-newX + label.center.x) >= 0 ? -newX : 0
            
            label.transform = CGAffineTransform(translationX: newX, y: 0)
            label.layoutIfNeeded()
            
        }, completion: completion)
    }
}

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
    
    private lazy var pulsator: Pulsator = Pulsator()
    
    var isPulseEnabled: Bool = false {
        didSet {
            switch isPulseEnabled {
            case true: pulsator.start()
            case false: pulsator.stop()
            }
        }
    }
    init() {
        
        super.init(frame: CGRect(origin: Positions.centerLeft.origin, size: Positions.buttonSize))
        center = Positions.centerLeft.origin
        
        layer.cornerRadius = Positions.buttonSize.width / 2
        setTitle("S", for: .normal)
        setTitleColor( .white, for: .normal)
        backgroundColor = StanwoodDebugger.Style.tintColor
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panning(_:)))
        addGestureRecognizer(pan)
        
        NotificationCenter.default.addObservers(self, observers: Stanwood.Observer(selector: #selector(didAddDebuggerItem(_:)), name: Notification.Name.DeuggerDidAddDebuggerItem))
    }
    
    func preparePulse() {
        pulsator.backgroundColor = StanwoodDebugger.Style.tintColor.cgColor
        pulsator.radius = Positions.buttonSize.width * 0.875
        pulsator.numPulse = 3
        pulsator.animationDuration = 3
        pulsator.position = center
        
        superview?.layer.insertSublayer(pulsator, below: layer)
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
        pulsator.position = center
        
        switch pan.state {
        case .ended, .cancelled:
            let position = Positions.position(for: center)
            pulsator.position = position.origin
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                self.center = position.origin
                self.transform = .identity
            }, completion: { _ in
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                    self.pulsator.opacity = 1
                }, completion: nil)
            })
        case .began:
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.pulsator.opacity = 0
            }, completion: nil)
        default:
            break
        }
    }
    
    @objc private func didAddDebuggerItem(_ notification: Notification) {
        guard let addedItem = notification.object as? AddedItem else { return }
        
        switch addedItem.type {
        case .analytics:
            animate(.analytics)
        case .error, .logs, .networking, .uiTesting: break
        }
    }
    
    private func animate(_ icon: DebuggerIcons) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        label.text = icon.rawValue
        label.center = center
        superview?.insertSubview(label, belowSubview: self)
        
        let toPoint = CGPoint(x: center.x, y: center.y - 250)
        icon.animate(label, toPoint: toPoint) { (label) in
            label.removeFromSuperview()
        }
    }
}
