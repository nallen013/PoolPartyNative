//
//  RideRequestViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/6/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import UIKit
import Firebase

class RideRequestViewController: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    
    @IBOutlet weak var SourceTextField: UITextField!
    @IBOutlet weak var DestinationTextField: UITextField!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameLabel.text = "Name: " + UserDefaults.standard.string(forKey: "name")!
        EmailLabel.text = "Email: " + UserDefaults.standard.string(forKey: "email")!
        PhoneLabel.text = "Phone: " + UserDefaults.standard.string(forKey: "phone")!
    }
    
    func submitForm() {
        let name = UserDefaults.standard.string(forKey: "name")
        let email = UserDefaults.standard.string(forKey: "email")
        let phone = UserDefaults.standard.string(forKey: "phone")
        
        let source = SourceTextField.text
        let destination = DestinationTextField.text
        
        let date = DateTimePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy at HH:mm:ss ZZZZZ"
        let dateString = dateFormatter.string(from: date)
        
        let db = Firestore.firestore()
        let jsonData = [
            "name": name,
            "email": email,
            "source": source,
            "destination": destination,
            "arrival_time": dateString
        ]
        var ref: DocumentReference? = nil
        ref = db.collection("Users").addDocument(data: jsonData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

    }
    
    @IBAction func OnClickCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func OnClickSubmit(_ sender: Any) {
        self.submitForm()
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
