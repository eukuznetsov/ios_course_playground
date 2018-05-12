//
//  ViewController.swift
//  Egg Timer
//
//  Created by Evgeney Kuznetsov on 12/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    var timeLeft = 0
    var timer = Timer()
    
    @IBOutlet var startTimerButton: UIBarButtonItem!
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if(!timer.isValid) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.secondSpent), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func increaseTimerButtonPressed(_ sender: Any) {
        setTimeLeft(timeLeft+10)
    }
    
    @IBAction func decreaseTimerButtonPressed(_ sender: Any) {
        setTimeLeft(timeLeft-10)
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        setTimeLeft(0)
    }
    
    @IBAction func pauseTimer(_ sender: Any) {
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func secondSpent() {
        setTimeLeft(timeLeft-1)
    }
    
    func setTimeLeft(_ time: Int) {
        if(time <= 0) {
            timer.invalidate()
            timeLeft = 0
        } else {
            timeLeft = time
        }
        timerLabel.text=String(timeLeft)
    }

}

