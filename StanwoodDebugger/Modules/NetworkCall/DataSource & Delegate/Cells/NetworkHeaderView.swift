//
//  NetworkHeaderView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import Foundation

class NetworkHeaderView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
        titleLabel.textColor = .black
    }
    
    private func clear() {
        titleLabel?.text = nil
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
}
