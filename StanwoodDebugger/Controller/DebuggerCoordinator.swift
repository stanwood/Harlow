//
//  DebuggerCoordinator.swift
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

class DebuggerCoordinator {
    
    private let window: UIWindow
    private let actionable: DebuggerActions
    private let paramaterable: DebuggerParamaters
    
    // need a better solution for it
    func currentViewController(base: UIViewController?) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return currentViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        
        return base
    }
    
    init(window: UIWindow, actionable: DebuggerActions, paramaterable: DebuggerParamaters) {
        self.window = window
        self.actionable = actionable
        self.paramaterable = paramaterable
    }
    
    // MARK: - List View
    
    func presentListView(with filter: DebuggerFilterView.DebuggerFilter, animated: Bool = false, completion: @escaping Completion) {
        
        let title = "Debugger"
        
        // Detail Nav Controller
        let detailControllers = ListWireframe.makeViewController(withTitle: title)
        let paramaters = ListParamaters(appData: self.paramaterable.appData, filter: filter)
        ListWireframe.prepare(detailControllers.viewController, with: actionable, paramaters)
        
        // Settings Nav Controller
        let settingsControllers = SettingsWireframe.makeViewController(withTitle: title)
        SettingsWireframe.prepare(settingsControllers.viewController, with: actionable, paramaterable)
        
        let tabBarController = DebuggerUITabBarController()
        tabBarController.setViewControllers([
            detailControllers.navigationController,
            settingsControllers.navigationController], animated: false)
        
        window.rootViewController?.present(tabBarController, animated: animated, completion: completion)
    }
    
    // MARK: - Networking
    func present(_ item: Recordable) {
        if let item = item as? NetworkItem {
            present(item)
        } else if let item = item as? ErrorItem {
            present(item)
        } else if let item = item as? CrashItem {
            present(item)
        }
    }
    
    private func present(_ item: NetworkItem) {
        let viewController = NetworkingWireframe.makeViewController()
        let parameters = NetworkingParameters(appData: self.paramaterable.appData, item: item)
        NetworkingWireframe.prepare(viewController, with: self.actionable, and: parameters)
        currentViewController(base: window.rootViewController)?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func present(_ item: ErrorItem) {
        let viewController = ErrorWireframe.makeViewController()
        let parameters = ErrorParameters(appData: self.paramaterable.appData, item: item)
        ErrorWireframe.prepare(viewController, with: self.actionable, and: parameters)
        currentViewController(base: window.rootViewController)?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ data: NetworkData) {
        let viewController = DataDetailWireframe.makeViewController()
        let parameters = DataDetailParameters(appData: self.paramaterable.appData, data: data)
        DataDetailWireframe.prepare(viewController, with: actionable, and: parameters)
        currentViewController(base: window.rootViewController)?.navigationController?.pushViewController(viewController, animated: true)
    }

    private func present(_ item: CrashItem) {
        let viewController = CrashWireframe.makeViewController()
        let parameters = CrashParameters(appData: self.paramaterable.appData, item: item)
        CrashWireframe.prepare(viewController, with: self.actionable, and: parameters)
        currentViewController(base: window.rootViewController)?.navigationController?.pushViewController(viewController, animated: true)
    }
    // MARK: - Settings
    
    enum ActionSheet: String {
        case analytics, allData, settings, networking, logs, errors, crashes
        
        var value: String {
            switch self {
            case .allData:
                return "all"
            case .settings, .analytics, .errors, .logs, .networking, .crashes:
                return rawValue
            }
        }
        
        var title: String {
            switch self {
            case .allData, .analytics, .errors, .logs, .networking, .crashes:
                return "Would you like to remove \(value) data?"
            case .settings:
                return "Reset to default settings?"
            }
        }
    }
    
    func shouldReset(_ type: ActionSheet, _ completion: @escaping () -> Void) {
        
        let completion: (UIAlertAction) -> Void = { _ in
            completion()
        }
        
        let items: [String: Bool] = [
            "Yes" : true,
            "No" : false
        ]
        
        presentAction(withTitle: type.title, completionItem: items, completion)
    }
    
    private func presentAction(withTitle title: String, completionItem: [String: Bool], _ actionCompletion: @escaping (UIAlertAction) -> Void) {
        
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        completionItem.forEach({
            let action = UIAlertAction(title: $0.key, style: $0.value ? .default : .cancel, handler: $0.value ? actionCompletion : nil)
            actionSheet.addAction(action)
        })
        
        currentViewController(base: window.rootViewController)?.present(actionSheet, animated: true, completion: nil)
    }
}
