//
//  DebuggerViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation

class DebuggerViewController: UIViewController {
    
    private var debuggerButton: DebuggerUIButton!
    private var debuggerScallableView: DebuggerScallableView?
    
    var presenter: DebuggerPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debuggerButton = DebuggerUIButton()
        debuggerButton.addTarget(self, action: #selector(didTapDebuggerButton(target:)), for: .touchUpInside)
        view.addSubview(debuggerButton)
    }

    @objc func didTapDebuggerButton(target: DebuggerUIButton) {
        presenter.debuggerable.isDisplayed = true
        if debuggerScallableView == nil {
            debuggerScallableView = DebuggerScallableView.loadFromNib() //(frame: CGRect(x: 0, y: 0, width: 0, height: 0), button: debuggerButton)
            view.addSubview(debuggerScallableView!)
        }
        presenter.presentScaled(debuggerScallableView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.debuggerable.isDisplayed = false
        debuggerButton.preparePulse()
        debuggerButton.isPulseEnabled = true
    }
    
    func shouldHandle(_ point: CGPoint) -> Bool {
        if presenter.debuggerable.isDisplayed {
            
            if let view = debuggerScallableView, !view.frame.contains(point) {
                debuggerScallableView?.dismiss()
                presenter.debuggerable.isDisplayed = false
            }
            
            return true
        }
        return debuggerButton.frame.contains(point)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
}
