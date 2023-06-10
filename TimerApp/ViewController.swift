//
//  ViewController.swift
//  TimerApp
//
//  Created by Gene Mueller on 6/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var clock = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentTime()
        Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    private func getCurrentTime() {
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime), userInfo: nil, repeats: true)
    }
    
    @objc func currentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        currentTimeLabel.text = Date().formatted(Date.FormatStyle().weekday(.abbreviated)) + ", " + formatter.string(from: Date())
    }
    
    @objc func updateCounter() {
        
        
        
    }


}

