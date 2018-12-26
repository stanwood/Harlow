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
    
    private var bodyRecorder: HTTPDataResponseRecorder?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func fill(with type: Type?) {
        guard let httpBodyRecorder = type as?  HTTPDataResponseRecorder else { return }
        bodyRecorder = httpBodyRecorder
        bodyLengthLabel.text = httpBodyRecorder.dataResponse?.byteString
    }
    
}
