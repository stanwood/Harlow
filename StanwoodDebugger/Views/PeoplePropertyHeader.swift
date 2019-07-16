//
//  PeoplePropertyHeader.swift
//  StanwoodDebugger
//
//  Created by AT on 7/16/19.
//

import UIKit

protocol PeoplePropertyHeaderDelegate: class {
    func showPeopleProperties()
}

class PeoplePropertyHeader: UIView {

    weak var delegate: PeoplePropertyHeaderDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func didSelectItem(_ sender: Any) {
        delegate?.showPeopleProperties()
    }
}
