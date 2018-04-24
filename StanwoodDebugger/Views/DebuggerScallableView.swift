//
//  DebuggerScallableView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 23/04/2018.
//

import Foundation

typealias Completion = () -> Void

protocol DebuggerScallableViewDelegate: class {
    func scallableViewIsExpanding(completion: @escaping Completion)
    func scallableViewDidDismiss()
}
class DebuggerScallableView: UIView {
    
    private var size: CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize(width: screenSize.width - 18, height: screenSize.height / 1.8 )
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var expandButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    
    weak var button: DebuggerUIButton!
    weak var delegate: DebuggerScallableViewDelegate?
    
    private var buttons: [UIView] {
        return [expandButton, closeButton, tableView]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        alpha = 0
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        buttons.hide(animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    func show() {
        center = button.center
        button.isPulseEnabled = false
        button.isEnabled = false

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.frame = CGRect(origin: .zero, size: self.size)
                self.center = UIApplication.shared.keyWindow?.center ?? .zero
                self.alpha = 1
            }, completion: { _ in
                self.buttons.show(duration: 0.3)
            })
        }
    }
    
    @objc func dismiss(fromExpandable isExpandable: Bool = false) {
        buttons.hide(duration: 0.3)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            self.frame = CGRect(origin: .zero, size: .zero)
            self.center = self.button.center
            self.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.button.transform = .identity
                self.button.isPulseEnabled = true
                self.button.isEnabled = true
            }, completion: { _ in
                self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
                if !isExpandable {
                    self.delegate?.scallableViewDidDismiss()
                }
            })
        }
    }
    
    @IBAction func expand(_ sender: Any) {
        buttons.hide()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame = UIApplication.shared.keyWindow?.frame ?? .zero
            self.backgroundColor = .white
        }) { _ in
            self.delegate?.scallableViewIsExpanding {
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(fromExpandable: true)
                }
            }
        }
    }
}
