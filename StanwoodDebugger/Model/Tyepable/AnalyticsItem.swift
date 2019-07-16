//
//  DebuggerItem.swift
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

struct AnalyticsItem: Typeable, Codable, Recordable {
    
    static func == (lhs: AnalyticsItem, rhs: AnalyticsItem) -> Bool {
        return lhs.itemId == rhs.itemId && lhs.superProperties == rhs.superProperties && lhs.eventName == rhs.eventName && lhs.contentType == rhs.contentType && lhs.screenName == rhs.screenName && lhs.createdAt == rhs.createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        case eventName, category, contentType, itemId, createdAt, screenName
    }
    
    var itemId: String?
    var eventName: String?
    var category: String?
    var contentType: String?
    var screenName: String?
    var createdAt: Date?
    var superProperties: PanelTypeWrapperItems?
    var formattedDate: String {
        guard let date = createdAt else { return "" }
        let format = "HH:mm:ss"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: date)
    }
}

public class PanelTypeWrapper: NSObject, Model, Codable {
    
    //var stringValue: DebugString?
    var stringValue: DebugString?

    var key: String
//    var numberValue: NSNumber?
//    var dateValue: Date?
//    var urlValue: URL?
    
//    var dictValue: NSArray?
//    var arrayValue: NSDictionary?
    
    /// TODO:- init with Mixpanel type
    
    public init(key: String, stringValue: String) {
        self.stringValue = stringValue as? DebugString
        self.key = key
    }
}

//public struct SuperPropertyWrapper: Model, Codable, Equatable {
//
//    public static func == (lhs: SuperPropertyWrapper, rhs: SuperPropertyWrapper) -> Bool {
//        return lhs.values ?? [:] == rhs.values ?? [:]
//    }
//
//    var values: [String: PanelTypeWrapper]?
//
//}



public class PanelTypeWrapperItems: Elements<PanelTypeWrapper>, Equatable {
    
    public static func == (lhs: PanelTypeWrapperItems, rhs: PanelTypeWrapperItems) -> Bool {
        return lhs.items == rhs.items
    }
}


class DebugString: NSString, Codable {
    
}
