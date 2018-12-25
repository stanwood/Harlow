//
//  NetworkItem.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 24/12/2018.
//

import Foundation
import StanwoodCore

struct NetworkItem: Typeable, Codable {
    
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
