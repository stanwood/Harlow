//
//  AppDelegate.swift
//  StanwoodDebugger
//
//  Created by talezion on 03/12/2018.
//  Copyright (c) 2018 talezion. All rights reserved.
//

import UIKit
import StanwoodDebugger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        StanwoodDebugger.shared.isEnabled = true
        
        return true
    }
}

