//
//  StatusCodes.swift
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
import UIKit

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
        default: self = .c100
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
