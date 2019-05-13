//
//  UIViewController+TopMost.swift
//  StanwoodDebugger
//
//  Created by Zolo on 2019. 05. 13..
//

import Foundation

extension UIViewController {
    @objc func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
            
            // Handling UIViewControllers added as subviews to some other views.
        else {
            for view in self.view.subviews {
                if let subViewController = view.next {
                    if let viewController = subViewController as? UIViewController {
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    override func topMostViewController() -> UIViewController {
        return self.selectedViewController!.topMostViewController()
    }
}

extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        return self.visibleViewController!.topMostViewController()
    }
}
