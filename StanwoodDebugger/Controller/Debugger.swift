//
//  Debugger.swift
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
import StanwoodCore

protocol Debugging: class {
    var isEnabled: Bool { get set }
    var isDisplayed: Bool { get set }
}

/// StanwoodDebugger acts as the framework controller, delegating logs
public class StanwoodDebugger: Debugging {
    
    /// Supported Services
    public enum Service: CaseIterable {
        case logs, networking, errors, crashes, analytics
    }
    
    struct Style {
        private init () {}
        static var tintColor: UIColor = UIColor(r: 210, g: 78, b: 79)
        static let defaultColor: UIColor = UIColor(r: 51, g: 51, b: 51)
    }
    
    /// Debugger tintColor
    public var tintColor: UIColor {
        get { return Style.tintColor }
        set { Style.tintColor = newValue; configureStyle() }
    }
    
    /// Error code exceptions
    public var errorCodesExceptions: [Int] = [] {
        didSet {
            DebuggerNSError.errorCodesExceptions = errorCodesExceptions
        }
    }
    
    /// Enabled Services: `default = .all`
    /// Note> You must call `isEnabled  = true` to enable the debugger
    public var enabledServices: [Service] = Service.allCases {
        didSet {
            self.isEnabled = isEnabled ? true : false
        }
    }
    
    /// Enable Debugger View
    public var isEnabled: Bool = false {
        didSet {
            DebuggerLogs.isEnabled = enabledServices.contains(.logs) ? isEnabled : false
            DebuggerNetworking.isEnabled = enabledServices.contains(.networking) ? isEnabled : false
            DebuggerNSError.isEnabled = enabledServices.contains(.errors) ? isEnabled : false
            DebuggerCrash.isEnabled = enabledServices.contains(.crashes) ? isEnabled : false
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
    private let debuggerNetworking: DebuggerNetworking
    
    public init() {
        window = DebuggerWindow(frame: UIScreen.main.bounds)
        
        appData = DebuggerData()
        paramaters = DebuggerParamaters(appData: appData)
        actions = DebuggerActions(appData: appData)
        debuggerNetworking = DebuggerNetworking()
        
        coordinator = DebuggerCoordinator(window: window, actionable: actions, paramaterable: paramaters)
        actions.coordinator = coordinator
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        configureStyle()
        observeCrashes()
    }
    
    /**
     Register custom `URLSessionConfiguration`
     
     ### Example Usage
     ```swift
     let configuration = URLSessionConfiguration.waitsForConnectivity
     
     debugger.regsiter(custom: configuration)
     
     /// Use with URLSession || any networking libraries such as Alamofire and Moya
     let session = URLSession(configuration: configuration)
     ```
     - Parameters:
        - configuration: URLSessionConfiguration
     
     - SeeAlso: `DebuggerNetworking`
     */
    public func regsiter(custom configuration: URLSessionConfiguration) {
        DebuggerNetworking.register(custom: configuration)
    }
    
    @objc func applicationDidEnterBackground() {
        appData.save()
    }
    
    private func configureStyle() {
        window.tintColor = Style.tintColor
    }
    
    private func observeCrashes() {
        DebuggerCrash.crashCompletion = {
            [unowned self] in
            self.appData.save()
        }
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

            if DebuggerCrash.didReceiveCrash {
                DebuggerCrash.didReceiveCrash = false
                NotificationCenter.default.post(name: NSNotification.Name.DebuggerDidAddDebuggerItem, object: [AddedItem(type: .crashes(item: nil), count: 1)])
            }
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
