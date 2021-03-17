//
//  NotificationCenter+Observer.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2020 Stanwood GmbH (www.stanwood.io)
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

import Foundation


/// A convinient observer class to add observers to `NotificationCenter`
public struct Observer {
    
    /// The observer selector
    public let selector: Selector
    
    /// The notification name
    public let name: Notification.Name
    
    /// The optional object to pass
    public let object: Any?
    
    /**
     A convinient observer class to add observers to `NotificationCenter`
     
     - Parameters:
     - selector: the selector to pass to the notification
     - name: the notification name
     - object: object of type `Any`, default = nil
     
     - SeeAlso:
     `NotificationCenter.addObserver(_:observer:)`
     `NotificationCenter.addObservers(_:observers:)`
     */
    public init(selector: Selector, name: Notification.Name, object: Any? = nil) {
        self.selector = selector
        self.name = name
        self.object = object
    }
}

extension NotificationCenter {
    
    /**
     Add an observer
     
     - Parameters:
     - target: the current target
     - observer: the observer to handle
     
     - SeeAlso: `Observer`
     */
    public func addObserver(_ target: Any, observer: Observer) {
        addObserver(target, selector: observer.selector, name: observer.name, object: observer.object)
    }
    
    /**
     Add observers
     
     - Parameters:
     - target: the current target
     - observers: the observers to handle
     
     - SeeAlso: `Observer`
     */
    public func addObservers(_ target: Any, observers: Observer...) {
        observers.forEach() {
            addObserver(target, selector: $0.selector, name: $0.name, object: $0.object)
        }
    }
}
