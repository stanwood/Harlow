//
//  CGFloat+Extension.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 30/07/2018.
//

import Foundation

extension CGFloat {
    
    static func random(between lowest: CGFloat, and highest: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(lowest - highest) + CGFloat.minimum(lowest, highest)
    }
}
