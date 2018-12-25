//
//  StatusCodes.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import Foundation

enum StatusCodes {
    case c100
    case c200
    case c300
    case c400
    case c500
    
    init(rawValue: Int) {
        switch rawValue {
        case 100...199: self = .c100
        case 200...299: self = .c200
        case 300...399: self = .c300
        case 400...499: self = .c400
        case 500...600: self = .c500
        default: self = .c200
        }
    }
    
    var color: UIColor {
        switch self {
        case .c100: return UIColor.gray.withAlphaComponent(0.5)
        case .c200: return UIColor(hex: "40C585")
        case .c300: return UIColor(hex: "34DFFF")
        case .c400: return UIColor(hex: "FC962A")
        case .c500: return UIColor(hex: "F83536")
        }
    }
}
