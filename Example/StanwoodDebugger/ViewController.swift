//
//  ViewController.swift
//  StanwoodDebugger
//
//  Created by talezion on 03/12/2018.
//  Copyright (c) 2018 talezion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapMe(_ sender: Any) {
        let alertController = UIAlertController(title: "Hi!", message: "Do you like StanwoodDebugger?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes😍", style: .default, handler: nil)
        let no = UIAlertAction(title: "No!🤬", style: .destructive, handler: nil)
        alertController.addAction(yes)
        alertController.addAction(no)
        
        UIApplication.shared.delegate?.window??.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
