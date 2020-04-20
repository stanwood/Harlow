//
//  NetworkingPresenter.swift
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

import SourceModel
import StanwoodCore

protocol NetworkingViewable: class {
    func setupTableView(modelCollection: ModelCollection?)
}

class NetworkingPresenter: Presentable {
    
    // MARK:- Properties
    
    weak var view: NetworkingViewable?
    var actions: NetworkingActionable
    var parameters: NetworkingParameterable
    
    // MARK:- Typealias
    
    typealias Actionable = NetworkingActionable
    typealias Parameterable = NetworkingParameterable
    typealias Viewable = NetworkingViewable
    
    // MARK:- Initialiser
    
    required init(actions: NetworkingActionable, parameters: NetworkingParameterable, view: NetworkingViewable) {
        self.view = view
        self.actions = actions
        self.parameters = parameters
    }
    
    // MARK:- Functions
    
    func viewDidLoad() {
        view?.setupTableView(modelCollection: parameters.sections)
    }
    
    func present(data: NetworkData) {
        actions.present(data: data)
    }
}
