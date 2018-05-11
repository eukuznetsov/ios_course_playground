//
//  ViewController.swift
//  HowManyFingers
//
//  Created by Evgeney Kuznetsov on 11/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var inputField: UITextField!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var responseLabel: UILabel!
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        let guessedNumber: String = String(arc4random_uniform(6))
        if(String(inputField.text!) == guessedNumber) {
            responseLabel.text = "You are right!"
        } else {
            responseLabel.text = "The answer was " + guessedNumber
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

