//
//  ExampleDelegate.swift
//  StanwoodDebugger_Example
//
//  Created by Tal Zion on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import StanwoodCore

class NetworkingManager {
    
    enum Method: String, Codable {
        case get, delete, post, put
    }
    
    var tasks = [URLSessionDataTask]()
    var session: URLSession!

    init() {
        session = URLSession.shared
    }
    
    func makePostRequest(with item: NetworkExample) {
        guard let url = URL(string: item.url) else {return}
        let request = NSMutableURLRequest(url: url)
        let parameters = ["username":"stanwood@debugger.io"]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpMethod = item.method.rawValue.uppercased()
        let task = session.dataTask(with: request as URLRequest, completionHandler: { _, response, error in
            if let response = response {
                print("response for url : [\(url)] : \(response)")
            }
            if let error = error {
                print(error)
            }
        })
        task.resume()
        tasks.append(task)
    }
    
    func makeRequest(with item: NetworkExample) {
        guard let url = URL(string: item.url) else {return}
        var request = URLRequest(url: url)
        
        if item.url.contains("headers") {
            request.setValue(UUID().uuidString, forHTTPHeaderField: "UUID")
            request.setValue("sald;kjfnap9ew8urqoiw;fao;idhfaowfq349", forHTTPHeaderField: "token")
        }
        
        let task = session.dataTask(with: request, completionHandler: { _, response, error in
            
        })
        task.resume()
    }
}

class ExampleDelegate: Stanwood.AbstractTableDelegate {
    
    let networkingManager = NetworkingManager()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? NetworkingExampleCell, let item = cell.item {
            if item.method == .post {
                networkingManager.makePostRequest(with: item)
            } else {
                networkingManager.makeRequest(with: item)
            }
            
        } else if let cell = tableView.cellForRow(at: indexPath) as? AnalyticsExampleCell, let item = cell.item {
            item.post()
        }
    }
}
