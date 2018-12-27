//
//  NetworkDataBodyCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

class NetworkDataBodyCell: UITableViewCell, Fillable {

    @IBOutlet private weak var bodyLengthLabel: UILabel!
    
    var item: HTTPDataBodyRecorder?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func fill(with type: Type?) {
        guard let httpBodyRecorder = type as?  HTTPDataBodyRecorder else { return }
        item = httpBodyRecorder
        bodyLengthLabel.text = httpBodyRecorder.httpBody?.prettyString
    }
    
}
