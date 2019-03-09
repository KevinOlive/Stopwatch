//
//  ViewController.swift
//  Stopwatch
//
//  Created by Kevin Olive on 3/7/19.
//  Copyright © 2019 Kevin Olive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
	
    var timer : Timer = Timer.init()
    var startTime : Date = Date()
    var elapsedTime : TimeInterval = 0.0
	
    enum TimerStatus {
        case running
        case paused
        case stopped
    }
    var timerStatus : TimerStatus = .stopped
    
    let resetValue : String = "0:00.0"
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		resetTimer()
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        switch timerStatus {
            // if paused and start is pressed, resume timer
        case .paused:
            startTime = Date() - elapsedTime
            // if stopped, reset timer
        case .stopped:
            startTime = Date()
            elapsedTime = 0.0
        case .running:
            return
        }
        startTimer()
        timerStatus = .running
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        switch timerStatus {
        case .paused:
            resetTimer()
				stopButton.setTitle("Stop", for: .normal)
        case .running:
            timerStatus = .paused
				startButton.setTitle("Resume", for: .normal)
				stopButton.setTitle("Reset", for: .normal)
        case .stopped:
            return
        }
        timer.invalidate()
    }
	
	func resetTimer() {
		timerStatus = .stopped
		elapsedTimeLabel.text = resetValue
		elapsedTime = 0.0
		startButton.setTitle("Start", for: .normal)
		stopButton.setTitle("Stop", for: .normal)

	}
	
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(displayElapsedTime), userInfo: nil, repeats: true)
    }
    
    @objc func displayElapsedTime() {
        
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .positional
//        formatter.allowedUnits = [ .minute, .second, .nanosecond ]
//        formatter.zeroFormattingBehavior = [ .pad ]
//        formatter.allowsFractionalUnits = true
		
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "m:ss.S"
        
        elapsedTime = Date().timeIntervalSince(startTime)
        
        
//        let formattedDuration = formatter.string(from: elapsedTime)
        let formattedDuration = dateFormat.string(from: Date.init(timeIntervalSinceReferenceDate: elapsedTime))
//        print(formattedDuration)
        elapsedTimeLabel.text = formattedDuration
    }
}

