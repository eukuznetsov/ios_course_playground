//
//  ViewController.swift
//  IsPrimeNumber
//
//  Created by Evgeney Kuznetsov on 12/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var inputField: UITextField!
    @IBOutlet var button: UIButton!
    @IBOutlet var messageLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: Any) {
        if inputField.text != nil, let enteredNumber = Int64(inputField.text!) {
            if isPrime(enteredNumber) {
                setMessage("\(enteredNumber) is prime")
            } else {
                setMessage("\(enteredNumber) is not prime")
            }
        } else {
            setMessage("Please, enter a positive number")
        }
        
    }
    
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
    
    func isPrime(_ number: Int64) -> Bool {
        if number == 1 {
            return true
        }
        var i: Int64 = 2
        while i < number {
            if number % i == 0 {
                return false
            }
            i+=1
        }
        return true
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

