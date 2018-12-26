//
//  NetworkLatencyCell.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import UIKit
import StanwoodCore

class NetworkLatencyCell: UITableViewCell, Fillable {

    @IBOutlet private weak var latencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func fill(with type: Type?) {
        guard let latency = type as? LatencyRecorder else { return }
       
        
        let duration = latency.duration ?? 0
        let ms = Int((duration.truncatingRemainder(dividingBy: 1)) * 1000)
        latencyLabel.text = "\(ms)ms"
    }
    
}
