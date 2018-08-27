//
//  Debugger.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation

protocol Debugging: class {
    var isEnabled: Bool { get set }
    var isDisplayed: Bool { get set }
}

/// StanwoodDebugger acts as the framework controller, delegating logs
public class StanwoodDebugger: Debugging {
    
    /// Debugger tintColor
    public var tintColor: UIColor {
        get { return Style.tintColor }
        set { Style.tintColor = newValue }
    }
    
    struct Style {
        private init () {}
        static var tintColor: UIColor = UIColor(r: 210, g: 78, b: 79)
        static let defaultColor: UIColor = UIColor(r: 51, g: 51, b: 51)
    }
    
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
        
        appData = DebuggerData()
        paramaters = DebuggerParamaters(appData: appData)
        actions = DebuggerActions(appData: appData)
        
        coordinator = DebuggerCoordinator(window: window, actionable: actions, paramaterable: paramaters)
        actions.coordinator = coordinator
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        window.tintColor = Style.tintColor
    }
    
    @objc func applicationDidEnterBackground() {
        appData.save()
    }
    
    private func configureDebuggerView() {
        switch isEnabled {
        case true:
            if debuggerViewController == nil {
                debuggerViewController = DebuggerWireframe.makeViewController()
                DebuggerWireframe.prepare(debuggerViewController, with: actions, paramaters, self)
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
