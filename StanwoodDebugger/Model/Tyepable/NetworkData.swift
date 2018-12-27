//
//  NetworkData.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

import Foundation

struct NetworkData {
    let data: Data
    var image: UIImage? {
        return UIImage(data: data)
    }
    var text: String? {
        let convertedString = String(data: data, encoding: .utf8)
        return convertedString
    }
    
    var isHTML: Bool {
        return text?.uppercased().contains("DOCTYPE HTML") ?? false
    }
}
