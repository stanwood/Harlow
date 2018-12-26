//
//  DebuggerScallableView.swift
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
import StanwoodCore

typealias Completion = () -> Void

protocol DebuggerScallableViewDelegate: class {
    func scallableViewIsExpanding(completion: @escaping Completion)
    func scallableViewDidDismiss()
}
class DebuggerScallableView: UIView {
    
    var currentFilter: DebuggerFilterView.DebuggerFilter = .analytics
    private var size: CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize(width: screenSize.width - 18, height: screenSize.height / 1.8 )
    }
    
    @IBOutlet private weak var filterView: DebuggerFilterOutletView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var expandButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    
    weak var button: DebuggerUIButton!
    weak var delegate: DebuggerScallableViewDelegate?
    
    var presenter: DebuggerPresenter!
    private var listDelegate: ListDelegate!
    private var listDataSource: ListDataSource!
    
    private var views: [UIView] {
        return [tableView, filterView]
    }
    private var buttons: [UIView] {
        return [expandButton, closeButton]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        alpha = 0
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        views.hide(animated: false)
        buttons.hide(animated: false)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.45
        layer.masksToBounds = false
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.DeuggerDidAddDebuggerItem, object: nil)
        
        filterView.delegate = self
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
                self.views.show(duration: 0.3)
                self.buttons.show(duration: 0.3)
            })
        }
    }
    
    func configureTableView(with items: DataType?) {
        
        tableView.register(UINib(nibName: AnalyticsCell.identifier, bundle: Bundle.debuggerBundle()), forCellReuseIdentifier: AnalyticsCell.identifier)
        tableView.register(UINib(nibName: NetworkingCell.identifier, bundle: Bundle.debuggerBundle()), forCellReuseIdentifier: NetworkingCell.identifier)
        
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        tableView.tableFooterView = UIView(frame: .zero)
        
        if (items?.numberOfItems ?? 0) == 0 {
            let emptyView = DebuggerEmptyView.loadFromNib(withFrame: tableView.frame, bundle: Bundle.debuggerBundle())
            emptyView?.setLabel(with: currentFilter)
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
        
        listDataSource = ListDataSource(dataType: items)
        listDelegate = ListDelegate(dataType: items)
        listDelegate.presenter = presenter
        
        tableView.dataSource = listDataSource
        tableView.delegate = listDelegate
    
        tableView.reloadData()
    }
    
    @objc func refresh() {
        tableView.reloadData()
    }
    
    @objc func dismiss(fromExpandable isExpandable: Bool = false) {
        views.hide(duration: 0.3)
        buttons.hide(duration: 0.3)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            self.frame = CGRect(origin: .zero, size: .zero)
            self.center = self.button.center
            self.alpha = isExpandable ? 1 : 0
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
        buttons.hide(duration: 0.3)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame = UIApplication.shared.keyWindow?.frame ?? .zero
            self.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        }) { _ in
            self.views.hide()
            self.delegate?.scallableViewIsExpanding {
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(fromExpandable: true)
                }
            }
        }
    }
}

extension DebuggerScallableView: DebuggerFilterViewDelegate {

    func debuggerFilterViewDidFilter(_ filter: DebuggerFilterView.DebuggerFilter) {
        self.currentFilter = filter
        
        let items = presenter.parameterable.getDeguggerItems(for: filter)
        
        if (items?.numberOfItems ?? 0) == 0 {
            let emptyView = DebuggerEmptyView.loadFromNib(withFrame: tableView.frame, bundle: Bundle.debuggerBundle())
            emptyView?.setLabel(with: filter)
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
        listDataSource.update(with: items)
        listDelegate.update(with: items)
        
        tableView.reloadData()
    }
}
