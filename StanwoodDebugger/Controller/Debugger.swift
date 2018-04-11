//
//  Debugger.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation

public class StanwoodDebugger {
    
    /// Enable Debugger View
    public var isEnabled: Bool = false {
        didSet {
            configureDebuggerView()
        }
    }
    
    /// Debugger Singleton
    public static let shared: StanwoodDebugger = StanwoodDebugger()
    
    fileprivate lazy var debuggerViewController = DebuggerViewController()
    private let window: DebuggerWindow
    var isDisplayed: Bool = false
    
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
