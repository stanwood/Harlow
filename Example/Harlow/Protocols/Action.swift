//
//  ActionItem.swift
//  Harlow_Example
//
//  Created by Lukasz Lenkiewicz on 05/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

protocol ActionItemable {
    func postAction()
}

protocol ActionItemCellable {
    var item: ActionItemable? { get }
}
