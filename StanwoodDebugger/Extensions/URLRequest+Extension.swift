//
//  URLRequest+Extension.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/12/2018.
//

import Foundation

extension URLRequest {
    
    var body: Data? {
        return httpBody ?? httpBodyStream.flatMap { stream in
            let data = NSMutableData()
            stream.open()
            while stream.hasBytesAvailable {
                var buffer = [UInt8](repeating: 0, count: 1024)
                let length = stream.read(&buffer, maxLength: buffer.count)
                data.append(buffer, length: length)
            }
            stream.close()
            return data as Data
        }
    }
}
