//
//  ErrorItem.swift
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
import SourceModel

struct ErrorItem: Typeable, Codable, Recordable {

    let domain: String
    let code: Int
    let localizedDescription: String
    var userInfo: [String: String]
    
    init(error: NSError) {
        domain = error.domain
        code = error.code
        localizedDescription = error.localizedDescription
        userInfo = [:]
        
        error.userInfo.forEach({
            if let value = $0.value as? String {
                userInfo[$0.key] = value
            }
        })
    }
    
    static func == (lhs: ErrorItem, rhs: ErrorItem) -> Bool {
        return lhs.code == rhs.code && lhs.domain == rhs.domain
    }
}
