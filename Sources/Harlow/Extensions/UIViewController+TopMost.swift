//
//  UIViewController+TopMost.swift
//  Harlow
//
//  Created by Zolo on 2019. 05. 13..
//

import Foundation
import UIKit

extension UIViewController {
    @objc func topMostViewController() -> UIViewController? {
        
        // Handling UIViewControllers added as subviews to some other views.
        guard let presented = self.presentedViewController else {
            for view in self.view.subviews {
                if let subViewController = view.next,
                    let viewController = subViewController as? UIViewController {
                    return viewController.topMostViewController()
                }
            }
            return self
        }
        
        
        // Handling Modal views
        return presented.topMostViewController()
    }
}

extension UITabBarController {
    override func topMostViewController() -> UIViewController? {
        return self.selectedViewController?.topMostViewController()
    }
}

extension UINavigationController {
    override func topMostViewController() -> UIViewController? {
        return self.visibleViewController?.topMostViewController()
    }
}
