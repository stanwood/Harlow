//
//  Dictionary+String.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

import Foundation

extension Dictionary where Key == String {
    
    var prettyString: String {
        var headers = String()
        headers += "[\n"
        forEach({
            headers += "   \($0.key) : \($0.value)\n"
        })
        headers += "]"
        return headers
    }
}
