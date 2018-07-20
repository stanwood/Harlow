//
//  FilterUIButton.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 20/07/2018.
//

import Foundation

class FilterUIButton: UIButton {
    
    private(set) var filter: DebuggerFilterView.DebuggerFilter?
    private var badgeLabel: UILabel!
    private var badgeWidthAnchor: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        badgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.borderWidth = 1
        badgeLabel.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.text = "33"
        badgeLabel.textAlignment = .center
        badgeLabel.font = UIFont.systemFont(ofSize: 13)
        
        superview?.addSubview(badgeLabel)
        badgeWidthAnchor = badgeLabel.widthAnchor.constraint(equalToConstant: 20)
        
        NSLayoutConstraint.activate([
            badgeLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            badgeWidthAnchor
            ])
        
        badgeLabel.layer.cornerRadius = badgeLabel.frame.width / 2
    }
    
    func setTitle(_ filter: DebuggerFilterView.DebuggerFilter?) {
        self.filter = filter
        [UIControlState.normal, UIControlState.highlighted].forEach({ setTitle(filter?.rawValue, for: $0) })
    }
    
    func set(selected: Bool) {
        switch selected {
        case true:
            setTitleColor(.white, for: .normal)
            backgroundColor = StanwoodDebugger.Style.tintColor
            badgeLabel.backgroundColor = .white
            badgeLabel.textColor = StanwoodDebugger.Style.tintColor
        case false:
            setTitleColor(StanwoodDebugger.Style.tintColor, for: .normal)
            backgroundColor = .white
            badgeLabel.backgroundColor = StanwoodDebugger.Style.tintColor
            badgeLabel.textColor = .white
        }
    }
    
    
}
