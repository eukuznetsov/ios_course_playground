//
//  ViewController.swift
//  Local Phone Storage
//
//  Created by Evgeney Kuznetsov on 12/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var phoneNumberField: UITextField!
    let phoneNumberKey = "phoneNumber"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadedValue = UserDefaults.standard.object(forKey: phoneNumberKey)
        if let number = loadedValue as? String {
            print("value restored")
            phoneNumberField.text = number
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func phoneNumberChanged(_ sender: Any) {
        UserDefaults.standard.set(phoneNumberField.text, forKey: phoneNumberKey)
        print("\(phoneNumberField.text) saved to local storage")
    }

}

