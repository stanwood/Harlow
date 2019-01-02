//
//  DebuggerIcon.swift
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
import UIKit

typealias AnimationCompletion = (UILabel) -> Void
typealias DoneCompletion = (Bool) -> Void

class DebuggerIconLabel: UILabel {
    
    enum DebuggerIcons: String {
        case analytics = "👻"
        case error = "⚠️"
        case logs = "✏️"
        case crashes = "📱"
        case networking = "📶"
        
        private var duration: TimeInterval {
            switch self {
            case .analytics: return 5
            case .networking: return 4
            case .error: return 6
            case .logs: return 4
            case .crashes: return 7
            }
        }
        
        func animate(_ label: UILabel, toPoint point: CGPoint, completion: @escaping AnimationCompletion){
            
            let completed: (Bool) -> Void = { [label = label] _ in
                completion(label)
            }
            
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
    
    private let icon: DebuggerIcons
    
    init(icon: DebuggerIcons ,frame: CGRect) {
        self.icon = icon
        super.init(frame: frame)
        
        text = icon.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(to point: CGPoint) {
        icon.animate(self, toPoint: point) { (label) in
            self.removeFromSuperview()
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
}
