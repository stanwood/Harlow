//
//  SettingsHeaderView.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import UIKit

class SettingsHeaderView: UICollectionReusableView {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    private func clear() {
        titleLabel.text = nil
    }
    
    func set(title: String) {
        titleLabel.text = title.uppercased()
    }
    
}
