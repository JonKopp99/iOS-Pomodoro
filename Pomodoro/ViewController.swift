//
//  ViewController.swift
//  Pomodoro
//
//  Created by Adriana González Martínez on 1/16/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // There are two types of time intervals:
    //   1. Pomodoro: working on a task for 25 minutes without interruptions
    //   2. Break: 5 minutes
    
    enum IntervalType {
        case Pomodoro
        case Break
    }
    
    // Array of intervals that make up one session specifying if it's a break or pomodor
    
    // Keeps track of where we are in the intervals
    var currentInterval = 0
    
    // Setting the duration of each type of interval in seconds, for testing purposes they are short.
    let pomodoroDuration = 10 // Real: 25 * 60
    let breakDuration = 5 //Real:  5 * 60
    
    var timeRemaining = 0
    
    // Timer
    var timer = Timer()
    var currentTime = 11
    var state = "Paused"
    var tomCount = 0
    //UI
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var tomatoImages: [UIImageView]!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //ACTION: Set button actions for startPauseButton, resetButton and closeButto
        startPauseButton.addTarget(self, action: #selector(startPauseButtonPressed), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closePauseButtonPressed), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        for i in tomatoImages{
            i.alpha = 0.4
        }
        self.messageLabel.text = "Press Start!"
        tomCount = 0
    }
    
    // MARK: Update UI

    func updateTomatoes(to tomatoes: Int) {
        var currentTomato = 1
        for tomatoIcon in tomatoImages {
            tomatoIcon.alpha = currentTomato <= tomatoes ? 1.0 : 0.2
            currentTomato += 1
        }
    }
    
    // MARK: Button Actions
    
    func scheduledTimerWithTimeInterval(){
        if(timer.isValid == false)
        {
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: {_ in self.doStuff()})
            state = "Running"
            self.startPauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    func doStuff()
    {
        if(tomCount <= 4)
        {
            if(state == "Running")
            {
                self.messageLabel.text = "KEEP WORKING!!!"
            currentTime -= 1
            if(currentTime == 10)
            {
                self.timeLabel.text = ("0:\(String(currentTime))")
            }else{
                self.timeLabel.text = ("0:0\(String(currentTime))")
                }
            if(currentTime == 0)
            {
                state = "Break"
                currentTime = 6
                tomCount += 1
                updateTomatoes(to: tomCount)
                self.timeLabel.text = ("0:05")
                self.messageLabel.text = "SNACK TIME!"
            }
            }else if(state == "Break")
            {
                
                currentTime -= 1
                self.timeLabel.text = ("0:0\(String(currentTime))")
                if(currentTime == 1)
                {
                    
                    state = "Running"
                    currentTime = 11
                }
            }
        }else
        {
            timer.invalidate()
            self.startPauseButton.setTitle("Start", for: .normal)
            self.messageLabel.text = "Working Completed!"
            
            let userDefaults = Foundation.UserDefaults.standard
            var completed = userDefaults.integer(forKey: "Completed")
            completed += 1
            userDefaults.set(completed, forKey: "Completed")
            
        }
    }
    
    @objc func startPauseButtonPressed() {
         if timer.isValid {
            timer.invalidate()
            self.messageLabel.text = "Paused"
            self.startPauseButton.setTitle("Start", for: .normal)
         }else{
            scheduledTimerWithTimeInterval()
        }
    }
    
    @objc func resetButtonPressed() {
        
        if timer.isValid {
            timer.invalidate()
        }
        tomCount = 0
        currentTime = 11
        state = "Paused"
        for i in tomatoImages{
            i.alpha = 0.4
        }
        self.messageLabel.text = "Press Start!"
        self.timeLabel.text = ""
        self.startPauseButton.setTitle("Start", for: .normal)
    }
    @objc func closePauseButtonPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
}


@IBDesignable extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
