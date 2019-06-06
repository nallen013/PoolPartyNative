//
//  FirstViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/5/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameLabel.text = UserDefaults.standard.string(forKey: "name")
        EmailLabel.text = UserDefaults.standard.string(forKey: "email")
        PhoneLabel.text = UserDefaults.standard.string(forKey: "phone")
    }
}

