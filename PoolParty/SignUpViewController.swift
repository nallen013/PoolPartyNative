//
//  SignUpViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/5/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController : UIViewController {
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GetStartedClicked(_ sender: Any) {
        UserDefaults.standard.set(NameTextField.text, forKey: "name")
        UserDefaults.standard.set(EmailTextField.text, forKey: "email")
        UserDefaults.standard.set(PhoneTextField.text, forKey: "phone")
        UserDefaults.standard.set("15075 Capital One Dr., Richmond, VA 23238", forKey: "dest")
    }
}
