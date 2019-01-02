//
//  AppDelegate.swift
//  StanwoodDebugger
//
//  Created by talezion on 03/12/2018.
//  Copyright (c) 2018 talezion. All rights reserved.
//

import UIKit
#if DEBUG
import StanwoodDebugger
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    #if DEBUG
    lazy var debugger: StanwoodDebugger = StanwoodDebugger()
    #endif
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        debugger.errorCodesExceptions = [4097]
        debugger.isEnabled = true
        #endif
        
        return true
    }
}

