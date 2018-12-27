//
//  NetworkDataResponseCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

class NetworkDataResponseCell: UITableViewCell, Fillable {

    @IBOutlet private weak var bodyLengthLabel: UILabel!
    
    var item: HTTPDataResponseRecorder?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .default
    }
    
    func fill(with type: Type?) {
        guard let httpBodyRecorder = type as?  HTTPDataResponseRecorder else { return }
        item = httpBodyRecorder
        bodyLengthLabel.text = httpBodyRecorder.dataResponse?.prettyString
    }
}
