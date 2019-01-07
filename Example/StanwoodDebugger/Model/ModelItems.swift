//
//  ModelItems.swift
//  StanwoodDebugger_Example
//
//  Created by Tal Zion on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class ModelItems {
   
    static let getImgesNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "https://httpbin.org/image/jpeg"),
        NetworkExample(method: .get, url: "https://httpbin.org/image/png"),
    ]
    
    static let getNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "https://httpbin.org/status/400"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/404"),
        NetworkExample(method: .get, url: "https://httpbin.org/headers"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/410"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/202"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/500"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/300"),
        NetworkExample(method: .get, url: "https://httpbin.org/status/100")
    ]
    
    static let responseFormatItems: [NetworkExample] = [
        NetworkExample(method: .get, url: "https://httpbin.org/json"),
        NetworkExample(method: .get, url: "https://httpbin.org/html"),
        NetworkExample(method: .get, url: "https://httpbin.org/xml"),
        NetworkExample(method: .get, url: "https://httpbin.org/robots.txt"),
        NetworkExample(method: .get, url: "https://httpbin.org/deny")
    ]
    
    static let postNetworkingItems: [NetworkExample] = [
        NetworkExample(method: .post, url: "https://httpbin.org/post")
    ]
    
    static let analyticsContentItems: [AnalyticExample] = [
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: "09873rf", category: "articles", contentType: "website"),
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: "asdf987", category: "foood", contentType: nil),
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: "cnaiodnc", category: nil, contentType: "product"),
        AnalyticExample(eventName: "content_type", screenName: nil, itemId: nil, category: nil, contentType: nil)
    ]
    
    static let analyticsScreenItems: [AnalyticExample] = [
        AnalyticExample(eventName: "", screenName: "home_view", itemId: nil, category: nil, contentType: nil)
    ]

    static let crashesContentItems: [CrashExample] = [
        CrashExample(type: .crash),
        CrashExample(type: .signal)
    ]
}
