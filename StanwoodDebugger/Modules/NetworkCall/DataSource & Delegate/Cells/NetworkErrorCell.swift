//
//  NetworkErrorCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

class NetworkErrorCell: UITableViewCell, Fillable {

    @IBOutlet private weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func fill(with type: Type?) {
        guard let errorRcording = type as? HTTPErrorRecorder else { return }
        errorLabel.text = errorRcording.errorDescription
    }
}
