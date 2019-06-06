//
//  ChangeDestinationViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/6/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class ChangeDestinationViewController: UIViewController {
    @IBOutlet weak var DestTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DestTextField.text = UserDefaults.standard.string(forKey: "dest")
    }
    
    @IBAction func OnClickedSave(_ sender: Any) {
        UserDefaults.standard.set(DestTextField.text, forKey: "dest")
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func OnClickedCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
