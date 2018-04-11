//
//  DebuggerWindow.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 11/04/2018.
//

import Foundation

protocol DebuggerWindowDelegate: class {
    func isPoint(inside point: CGPoint) -> Bool
}

class DebuggerWindow: UIWindow {
    
    weak var delegate: DebuggerWindowDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        windowLevel = UIWindowLevelStatusBar - 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return delegate?.isPoint(inside: point) ?? false
    }
}
