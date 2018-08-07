//
//  Bundle+Debugger.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/04/2018.
//

import Foundation

extension Bundle {
    
    static func debuggerBundle() -> Bundle {
        return Bundle(for: StanwoodDebugger.self)
    }
    
    static func debuggerBundle(from target: AnyClass) -> Bundle {
        let podBundle = Bundle(for:  target)
        guard let bundleURL = podBundle.url(forResource: "StanwoodDebugger", withExtension: "bundle"),
        let bundle = Bundle(url: bundleURL) else { fatalError("Must have a local bundle") }
        return bundle
    }
    
}
