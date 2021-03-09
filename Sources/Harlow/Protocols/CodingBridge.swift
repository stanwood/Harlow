//
//  CodingBridge.swift
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


/// Coding bridge is a helper struct that bridge NSCoding and Codable objects
public struct CodingBridge<Coding>: Codable where Coding: NSCoding {
    
    /// Coding object
    public var coding: Coding?
    
    public init(_ coding: Coding?) { self.coding = coding }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        
        
        if Coding.self == UIImage.self {
            guard let object = UIImage(data: data) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "failed to unarchive an object")
            }
            
            self.coding = object as? Coding
            return
        } else {
            guard let object = NSKeyedUnarchiver.unarchiveObject(with: data) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "failed to unarchive an object")
            }
            
            guard let wrapped = object as? Coding else {
                throw DecodingError.typeMismatch(Coding.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "unarchived object type was \(type(of: object))"))
            }
            self.coding = wrapped
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        guard let coding = coding else { return }
        
        var data: Data
        if let image = coding as? UIImage {
            data = image.pngData() ??
                NSKeyedArchiver.archivedData(withRootObject: coding)
        } else {
            data = NSKeyedArchiver.archivedData(withRootObject: coding)
        }
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }
}
