//
//  Debugger.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation

protocol Debuggerable: class {
    var isEnabled: Bool { get set }
    var isDisplayed: Bool { get set }
}

/// StanwoodDebugger acts as the framework controller, delegating logs
public class StanwoodDebugger: Debuggerable {
    
    /// Enable Debugger View
    public var isEnabled: Bool = false {
        didSet {
            configureDebuggerView()
        }
    }
    
    var isDisplayed: Bool = false
    fileprivate var debuggerViewController: DebuggerViewController?
    private let window: DebuggerWindow
    private let coordinator: DebuggerCoordinator
    private let actions: DebuggerActions
    private let appData: DebuggerData
    private let paramaters: DebuggerParamaters
    
    public init() {
        window = DebuggerWindow(frame: UIScreen.main.bounds)
        actions = DebuggerActions()
        appData = DebuggerData()
        paramaters = DebuggerParamaters(appData: appData)
        coordinator = DebuggerCoordinator(window: window, actionable: actions, paramaterable: paramaters)
        actions.coordinator = coordinator
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func applicationDidEnterBackground() {
        appData.save()
    }
    private func configureDebuggerView() {
        switch isEnabled {
        case true:
            if debuggerViewController == nil {
                let presenter = DebuggerPresenter(debuggerable: self, actionable: actions)
                debuggerViewController = DebuggerViewController()
                debuggerViewController?.presenter = presenter
            }
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
        return debuggerViewController?.shouldHandle(point) ?? false
    }
}
