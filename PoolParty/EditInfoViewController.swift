//
//  EditInfoViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/6/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import UIKit

class EditInfoViewController: UIViewController {
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameTextField.text = UserDefaults.standard.string(forKey: "name")
        EmailTextField.text = UserDefaults.standard.string(forKey: "email")
        PhoneTextField.text = UserDefaults.standard.string(forKey: "phone")
    }
    
    @IBAction func CancelOnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveOnClick(_ sender: Any) {
        UserDefaults.standard.set(NameTextField.text, forKey: "name")
        UserDefaults.standard.set(EmailTextField.text, forKey: "email")
        UserDefaults.standard.set(PhoneTextField.text, forKey: "phone")
        
        dismiss(animated: true, completion: nil)
    }
}
