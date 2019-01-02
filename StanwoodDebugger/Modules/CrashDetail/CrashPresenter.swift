//
//  ErrorWireframe.swift
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

import StanwoodCore

protocol CrashViewable: class {
    func setupTableView(dataType: DataType?)
}

class CrashPresenter: Presentable {

    // MARK:- Properties
    
    unowned var viewable: CrashViewable
    var actionable: CrashActionable
    var parameterable: CrashParameterable
    var dataSource: CrashDataSource!
    var delegate: CrashDelegate!
    
    // MARK:- Typealias
    
    typealias Actionable = CrashActionable
    typealias Parameterable = CrashParameterable
    typealias Viewable = CrashViewable

    required init(actionable: CrashActionable, parameterable: CrashParameterable, viewable: CrashViewable) {
        self.viewable = viewable
        self.actionable = actionable
        self.parameterable = parameterable
    }
    
    func viewDidLoad() {
        viewable.setupTableView(dataType: parameterable.sections)
    }
    
}
