//
//  DebuggerViewController.swift
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

protocol DebuggerViewable: class {
    var debuggerScallableView: DebuggerScallableView? { get set }
}

class DebuggerViewController: UIViewController, DebuggerViewable {
    
    private var debuggerButton: DebuggerUIButton!
    var debuggerScallableView: DebuggerScallableView?
    
    var presenter: DebuggerPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debuggerButton = DebuggerUIButton(debugger: presenter.debugger)
        debuggerButton.addTarget(self, action: #selector(didTapDebuggerButton(target:)), for: .touchUpInside)
        view.addSubview(debuggerButton)
    }

    @objc func didTapDebuggerButton(target: DebuggerUIButton) {
        presenter.debugger.isDisplayed = true
        if debuggerScallableView == nil {
            debuggerScallableView = DebuggerScallableView.loadFromNib(withFrame: .zero, bundle: Bundle.debuggerBundle(from: type(of: self)))
            debuggerScallableView?.button = debuggerButton
            debuggerScallableView?.delegate = self
            view.addSubview(debuggerScallableView!)
        }
        
        presenter.refresh()
        
        presenter.presentScaled(debuggerScallableView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.debugger.isDisplayed = false
        debuggerButton.preparePulse()
        debuggerButton.isPulseEnabled = true
    }
    
    func shouldHandle(_ point: CGPoint) -> Bool {
        if presenter.debugger.isDisplayed {
            
            if let view = debuggerScallableView, !view.frame.contains(point), isViewLoaded, view.window != nil {
                debuggerScallableView?.dismiss()
                presenter.debugger.isDisplayed = false
            }
            
            return true
        }
        return debuggerButton.frame.contains(point)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // TODO
    }
}

extension DebuggerViewController: DebuggerScallableViewDelegate {
    func scallableViewIsExpanding(with filter: DebuggerFilterView.DebuggerFilter, completion: @escaping Completion) {
        presenter.presentDetailView(with: filter, completion: completion)
    }
    
    func scallableViewDidDismiss() {
        presenter.debugger.isDisplayed = false
    }
}
