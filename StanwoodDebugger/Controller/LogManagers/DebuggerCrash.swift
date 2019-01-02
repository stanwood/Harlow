//
//  DebuggerLogs.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Stanwood GmbH (www.stanwood.io)
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

class DebuggerCrash {

    static var isEnabled: Bool = true {
        didSet {
            switch isEnabled {
            case true:
                DebuggerCrash.register()
            case false:
                DebuggerCrash.unregister()
            }
        }
    }

    private class func register() {
        NSSetUncaughtExceptionHandler(DebuggerCrash.didCatchException)
        signal(SIGABRT, DebuggerCrash.didCatchSignal)
        signal(SIGILL, DebuggerCrash.didCatchSignal)
        signal(SIGSEGV, DebuggerCrash.didCatchSignal)
        signal(SIGFPE, DebuggerCrash.didCatchSignal)
        signal(SIGBUS, DebuggerCrash.didCatchSignal)
        signal(SIGPIPE, DebuggerCrash.didCatchSignal)
        signal(SIGTRAP, DebuggerCrash.didCatchSignal)
        signal(SIGSYS, DebuggerCrash.didCatchSignal)
    }

    private class func unregister() {
        NSSetUncaughtExceptionHandler(nil)
        signal(SIGABRT, SIG_DFL)
        signal(SIGILL, SIG_DFL)
        signal(SIGSEGV, SIG_DFL)
        signal(SIGFPE, SIG_DFL)
        signal(SIGBUS, SIG_DFL)
        signal(SIGPIPE, SIG_DFL)
        signal(SIGTRAP, SIG_DFL)
        signal(SIGSYS, SIG_DFL)
    }

    private static let didCatchException: @convention(c) (NSException) -> Void = { exception in
        guard DebuggerCrash.isEnabled else { return }
        let crashItem = CrashItem(exception: exception)
        didCatch(crash: crashItem)
    }

    private static let didCatchSignal: @convention(c) (Int32) -> Void = { signal in
        guard DebuggerCrash.isEnabled else { return }
        let crashItem = CrashItem(signal: signal, stack: Thread.callStackSymbols)
        didCatch(crash: crashItem)
    }

    private static func didCatch(crash: CrashItem) {
        NotificationCenter.default.post(name: NSNotification.Name.DeuggerDidReceiveCrashItem, object: crash)
    }

}
