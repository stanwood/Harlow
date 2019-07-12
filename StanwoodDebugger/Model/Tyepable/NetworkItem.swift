//
//  NetworkItem.swift
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

protocol NetworkOverviewable {
    var formattedDate: String { get }
    var url: String { get }
    var codeType: StatusCodes { get }
    var code: Int { get }
}

protocol LatencyRecorder {
    var duration: Double? { get }
}

protocol ResponseHeaderable {
    var headers: [String: String]? { get }
}

protocol HTTPDataBodyRecorder {
    var httpBody: Data? { get }
}

protocol HTTPDataResponseRecorder {
    var dataResponse: Data? { get }
}

protocol HTTPResponseable {
    var code: Int { get }
    var responseHeaders: [String: String]? { get }
}

protocol HTTPErrorRecorder {
    var errorDescription: String? { get }
}

struct NetworkItem: Typeable, Codable, NetworkOverviewable, LatencyRecorder, ResponseHeaderable, HTTPDataBodyRecorder, HTTPDataResponseRecorder, HTTPResponseable, HTTPErrorRecorder, Recordable {
    
    let id: String
    let url: String
    let requestDate: Date
    let method: String
    var headers: [String: String]?
    var httpBody: Data?
    var code: Int
    var dataResponse: Data?
    var errorDescription: String?
    var duration: Double?
    var responseHeaders: [String: String]?
    
    var codeType: StatusCodes {
        return StatusCodes(rawValue: code)
    }
    
    var formattedDate: String {
        let format = "HH:mm:ss"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: requestDate)
    }
    
    init?(request: URLRequest?) {
        guard let request = request else { return nil }
        requestDate = Date()
        id = UUID().uuidString
        method = request.httpMethod ?? "N/A"
        url = request.url?.absoluteString ?? ""
        headers = request.allHTTPHeaderFields
        httpBody = request.httpBody
        code = -1
    }
    
    mutating func set(response: URLResponse) {
        guard let responseHttp = response as? HTTPURLResponse else {return}
        responseHeaders = responseHttp.allHeaderFields as? [String : String]
        code = responseHttp.statusCode
    }
}
