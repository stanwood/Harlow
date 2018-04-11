//
//  Debugger.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
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

public class StanwoodDebugger {
    
    /// Debugger Singleton
    public static let shared: StanwoodDebugger = StanwoodDebugger()
    
    fileprivate lazy var debuggerViewController = DebuggerViewController()
    private let window: DebuggerWindow
    var isDisplayed: Bool = false
    
    /// Enable Debugger View
    public var isEnabled: Bool = false {
        didSet {
            configureDebuggerView()
        }
    }
    
    private init() {
        window = DebuggerWindow(frame: UIScreen.main.bounds)
    }
    
    private func configureDebuggerView() {
        switch isEnabled {
        case true:
            window.rootViewController = debuggerViewController
            window.makeKeyAndVisible()
            window.delegate = self
        case false:
            window.rootViewController = nil
            window.resignKey()
            window.removeFromSuperview()
       }
    }
}

extension StanwoodDebugger: DebuggerWindowDelegate {
    
    func isPoint(inside point: CGPoint) -> Bool {
        return debuggerViewController.shouldHandle(point)
    }
}
