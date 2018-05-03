//
//  DebuggerElements.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 27/04/2018.
//

import Foundation

class DebuggerElements: Sourceable {
    
    var numberOfItems: Int {
        return 0
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    subscript(indexPath: IndexPath) -> Item? {
        return nil
    }
    
    subscript(section: Int) -> Sourceable {
        return self
    }
}
