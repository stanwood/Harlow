//
//  NetworkItem.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/12/2018.
//

import Foundation
import StanwoodCore

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

struct NetworkItem: Typeable, Codable, NetworkOverviewable, LatencyRecorder, ResponseHeaderable, HTTPDataBodyRecorder, HTTPDataResponseRecorder {
    
    let id: String
    let url: String
    let requestDate: Date
    let method: String
    let headers: [String: String]?
    var httpBody: Data?
    var code: Int
    var dataResponse: Data?
    var errorDescription: String?
    var duration: Double?
    
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
        code = responseHttp.statusCode
    }
}
