//
//  DebuggerLogs.swift
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
import UIKit

public func debugPrint(_ items: Any...) {
    let output = items.map { "\($0)" }.joined(separator: " ") + "\n"
    DebuggerLogs.log(output: output)
    NSLog(output)
}

public func print(_ items: Any...) {
    let output = items.map { "\($0)" }.joined(separator: " ") + "\n"
    DebuggerLogs.log(output: output)
    NSLog(output)
}

public enum Swift {
    public static func print(_ items: Any..., separator: String = " ", terminator: String = " ") {
        let output = items.map { "\($0)" }.joined(separator: " ") + "\n"
        DebuggerLogs.log(output: output)
        NSLog(output)
    }
    
    public static func debugPrint(_ items: Any..., separator: String = " ", terminator: String = " ") {
        let output = items.map { "\($0)" }.joined(separator: " ") + "\n"
        DebuggerLogs.log(output: output)
        NSLog(output)
    }
}

class DebuggerLogs {
    
    static var isEnabled: Bool = true
    
    fileprivate static func log(output: String) {
        if DebuggerLogs.isEnabled {
            let logItem = LogItem(text: output)
            NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidReceiveLogItem, object: logItem)
        }
    }
}
