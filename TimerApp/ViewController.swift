//
//  ViewController.swift
//  TimerApp
//
//  Created by Gene Mueller on 6/10/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    var clock = Timer()
    var timeRemaining = 0
    var timerOn = false
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gets the current time
        getCurrentTime()
        // Do any additional setup after loading the view.
    }
    
    private func getCurrentTime() {
        // gets a current time for the clock itself on the top
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime), userInfo: nil, repeats: true)
    }
    
    @objc func currentTime() {
        // formats the date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        // prints the date out on the label
        currentTimeLabel.text = Date().formatted(Date.FormatStyle().weekday(.abbreviated)) + ", " + formatter.string(from: Date())
        changeBackground()
        // call a function to reduce the countdown duration 1 every second
        print(timerOn)
        print(timeRemaining)
        if (timerOn == true) {
            countDown()
        }
    }
    
    func countDown() {
        timeRemaining -= 1
        remainingTimeLabel.text = "Time Remaining: " + String(format: "%02d", timeRemaining / 3600) + ":" + String(format: "%02d", (timeRemaining % 3600) / 60) + ":" + String(format: "%02d", (timeRemaining % 3600) % 60)
        if (timeRemaining == 0 && timerOn == true) {
            timerOver()
        }
    }

    func timerOver() {
        timerOn = false
        playSound()
        timerButton.setTitle("Stop Music", for: .normal)
    }
    
    func changeBackground() {
        let hour  = Calendar.current.component(.hour, from: Date())
        if (hour < 12) {
            self.view.backgroundColor = .cyan
        } else {
            self.view.backgroundColor = .lightGray
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        if (player != nil) {
            player.stop()
            timerButton.setTitle("Start Timer", for: .normal)
            player = nil
        } else if (timerOn == false) {
            timerOn = true
            timerButton.setTitle("Stop Timer", for: .normal)
            timeRemaining = Int(timePicker.countDownDuration)
        } else if (timerOn == true) {
            timerOn = false
            timerButton.setTitle("Start Timer", for: .normal)
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "audio_sample", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

