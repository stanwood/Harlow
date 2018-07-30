//
//  DebuggerIcon.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 30/07/2018.
//

import Foundation

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
