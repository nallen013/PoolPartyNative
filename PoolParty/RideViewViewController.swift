//
//  RideViewViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/6/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import UIKit

class RideViewViewController : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OnClickedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
