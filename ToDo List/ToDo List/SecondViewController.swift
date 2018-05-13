//
//  SecondViewController.swift
//  ToDo List
//
//  Created by Evgeney Kuznetsov on 13/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var taskInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTask(_ sender: Any) {
        if let text = taskInputField.text {
            if !text.isEmpty {
                var list = UserDefaults.standard.object(forKey:FirstViewController.listDefaultsKey) as? Array<String>
                if list == nil {
                    list = Array<String>()
                }
                list?.append(text)
                UserDefaults.standard.set(list, forKey: FirstViewController.listDefaultsKey)
                print("Updated list saved: \(list)")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

