//
//  FirstViewController.swift
//  Pomodoro
//
//  Created by Adriana González Martínez on 1/16/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//  Initial app found here www.globalnerdy.com/2017/06/28/the-code-for-tampa-ios-meetups-pomodoro-timer-exercise

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var butt: UIView!
    static var completedCycles = Int()
    var messageLabel =  UILabel()
    
    deinit {
        //ACTION: Remove observers
       
    }
    override func viewDidAppear(_ animated: Bool) {
        messageLabel.frame = CGRect(x: 10, y: self.view.bounds.height / 2 + 25, width: self.view.bounds.width - 20, height: 50)
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.font = UIFont(name: "Avenir-Bold", size: 20)
        self.view.addSubview(messageLabel)
        messageLabel.text = "\(String(FirstViewController.completedCycles)) pomodoro cycles completed today"
        
        let userDefaults = Foundation.UserDefaults.standard
        //userDefaults.set(0, forKey: "Completed")
        let completed = userDefaults.integer(forKey: "Completed")
        messageLabel.text = "\(String(completed)) pomodoro cycles completed today"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //ACTION: Add observers
        
        
    }
    
    @objc func receivedNotification(_ notification:Notification) {
        // ACTION: Update value of completed cycles
        // ACTION: Update message label
        
    }
}

