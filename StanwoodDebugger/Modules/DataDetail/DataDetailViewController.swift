//
//  DataDetailViewController.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 26/12/2018.
//

import UIKit
import WebKit

class DataDetailViewController: UIViewController {
    
    var presenter: DataDetailPresenter!
    private var dataItem: NetworkData?
    private var scrollView: UIScrollView?
    private var imageView: UIImageView?
    private var imageViewFrame: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.viewDidLoad()
    }
    
    @objc func handleTap() {
        guard let imageView = imageView else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            imageView.frame = self.imageViewFrame
            self.scrollView?.zoomScale = 1.0
        }, completion: nil)
    }
    
    fileprivate func present(text: String, frame: CGRect) {
        let textView = UITextView(frame: frame)
        textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        textView.addInnerShadow(onSide: .all)
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.isSelectable = false
        textView.text = text
        textView.textColor = UIColor.black.withAlphaComponent(0.9)
        textView.font = UIFont(name: "Menlo-Regular", size: 15)
        view.addSubview(textView)
        
        let copyButton = UIButton(frame: CGRect(x: textView.frame.width - 44, y: textView.frame.origin.y, width: 44, height: 44))
        let image = UIImage(named: "icon_copy", in: Bundle.debuggerBundle(), compatibleWith: nil)
        copyButton.setImage(image, for: .normal)
        copyButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 15, right: 5)
        copyButton.addTarget(self, action: #selector(copyToClipboard(_:)), for: .touchUpInside)
        view.insertSubview(copyButton, aboveSubview: textView)
    }
    
    @objc func copyToClipboard(_ sender: UIButton) {
        guard let text = dataItem?.text, !text.isEmpty else {
            
            view.makeToast("No text to copy to clipboard", duration: 3.0, position: .bottom)
            return
        }
        
        UIPasteboard.general.string = dataItem?.text
        view.makeToast("Copied text to clipboard", duration: 3.0, position: .bottom)
    }
    
    fileprivate func present(htmlString: String, frame: CGRect) {
        let webView = WKWebView(frame: frame)
        view.addSubview(webView)
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    fileprivate func present(_ image: UIImage, frame: CGRect) {
        scrollView = UIScrollView(frame: frame)
        scrollView?.isUserInteractionEnabled = true
        scrollView?.zoomScale = 1.0
        scrollView?.minimumZoomScale = 1.0
        scrollView?.maximumZoomScale = 3.0
        
        if let scrollView = scrollView {
            view.addSubview(scrollView)
            
            let imageView = UIImageView(image: image)
            imageView.alpha = 0
            self.imageView = imageView
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tap.numberOfTapsRequired = 2
            imageView.addGestureRecognizer(tap)
            
            scrollView.delegate = self
            scrollView.addSubview(imageView)
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                self.imageView?.alpha = 1
            }, completion:  { _ in
                self.imageViewFrame = imageView.frame
            })
        }
    }
}

extension DataDetailViewController: DataDetailViewable, UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func show(_ networkData: NetworkData) {
        
        dataItem = networkData
        
        let heightOffset: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        let statusBarOffset: CGFloat = UIApplication.shared.statusBarFrame.height
        let offset = heightOffset + statusBarOffset
        let frame = CGRect(x: 0, y: offset, width: view.frame.width, height: view.frame.height - offset)
        
        if let image = networkData.image {
            present(image, frame: frame)
        } else if networkData.isHTML {
            present(htmlString: networkData.text ?? "", frame: frame)
        } else if let text = networkData.text {
            present(text: text, frame: frame)
        }
    }

    var navigationBarTitle: String? {
        get { return title ?? navigationItem.title }
        set { title = newValue }
    }
}
