//
//  NetworkResponseCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }
}

class NetworkResponseCell: UITableViewCell, Fillable {

    @IBOutlet private weak var responseLabel: UILabel!
    @IBOutlet private weak var responseHeadersTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        main(deadline: .milliseconds(50)) { /// There is a weird black stripe added
            self.responseHeadersTextView.addInnerShadow(onSide: .all)
        }
    }

    func fill(with type: Type?) {
        guard let response = type as? HTTPResponseable else { return }
        responseLabel.text = HTTPURLResponse.localizedString(forStatusCode: response.code).capitalizingFirstLetter()
        responseHeadersTextView.text = response.responseHeaders?.prettyString
    }
}
