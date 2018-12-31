//
//  ErrorCodeCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import UIKit
import StanwoodCore

class ErrorCodeCell: UITableViewCell, Fillable {

    @IBOutlet weak var codeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func fill(with type: Type?) {
        guard let item = type as? ErrorItem else { return }
        codeLabel.text = String(item.error.coding?.code ?? 0)
    }
}
