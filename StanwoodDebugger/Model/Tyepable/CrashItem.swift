//
//  CrashItem.swift
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
import StanwoodCore

struct StackItem: Typeable, Codable {
    let text: String

    var isAppStack: Bool {
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return text.contains(appName)
        }
        return false
    }
    
}

struct CrashItem: Typeable, Codable, Recordable {

    enum CrashType: String, Codable {
        case signal, exception
    }

    var name: String {
        switch type {
        case .exception:
            return exception?.coding?.name.rawValue ?? ""
        case .signal:
            return name(for: signal)
        }
    }

    var description: String? {
        switch type {
        case .exception:
            return exception?.coding?.description
        case .signal:
            return "Signal \(name): \(signal ?? 0) was raised."
        }
    }

    let date: Date
    let signal: Int32?
    let stack: [StackItem]
    let exception: Stanwood.CodingBridge<NSException>?
    let type: CrashType
    let appInfo: String

    init(exception: NSException, appInfo: String) {
        self.stack = exception.callStackSymbols.map { StackItem(text: $0) }
        self.exception = Stanwood.CodingBridge<NSException>(exception)
        self.signal = nil
        self.type = .exception
        self.date = Date()
        self.appInfo = appInfo
    }

    init(signal: Int32, stack: [String]?, appInfo: String) {
        self.stack = (stack ?? []).map { StackItem(text: $0) }
        self.exception = nil
        self.signal = signal
        self.type = .signal
        self.date = Date()
        self.appInfo = appInfo
    }

    var formattedDate: String {
        let format = "HH:mm:ss"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: date)
    }

    static func == (lhs: CrashItem, rhs: CrashItem) -> Bool {
        return lhs.exception?.coding == rhs.exception?.coding
    }

    private func name(for signal:Int32?) -> String {
        guard let signal = signal else {
            return "MISSING"
        }

        switch (signal) {
        case SIGABRT:
            return "SIGTRAP"
        case SIGABRT:
            return "SIGABRT"
        case SIGILL:
            return "SIGILL"
        case SIGSEGV:
            return "SIGSEGV"
        case SIGFPE:
            return "SIGFPE"
        case SIGBUS:
            return "SIGBUS"
        case SIGPIPE:
            return "SIGPIPE"
        default:
            return "OTHER"
        }
    }
}
