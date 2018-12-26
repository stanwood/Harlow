//
//  Data+Extension.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

import Foundation

extension Data {
    
    var byteString: String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(count))
        return string
    }
}
