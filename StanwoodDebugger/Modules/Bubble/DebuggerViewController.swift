//
//  DebuggerViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 10/04/2018.
//

import Foundation

class DebuggerViewController: UIViewController {
    
    private var debuggerButton: DebuggerUIButton!
    var presenter: DebuggerPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debuggerButton = DebuggerUIButton()
        debuggerButton.addTarget(self, action: #selector(didTapDebuggerButton(target:)), for: .touchUpInside)
        view.addSubview(debuggerButton)
    }

    @objc func didTapDebuggerButton(target: UIButton) {
        presenter.debuggerable.isDisplayed = true
        presenter.presentDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.debuggerable.isDisplayed = false
        debuggerButton.activatePulse()
    }
    
    func shouldHandle(_ point: CGPoint) -> Bool {
        if presenter.debuggerable.isDisplayed {
            return true
        }
        return debuggerButton.frame.contains(point)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
}
