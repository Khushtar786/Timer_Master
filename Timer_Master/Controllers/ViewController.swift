//
//  ViewController.swift
//  Timer_Master
//
//  Created by MacMini104 on 28/01/20.
//  Copyright © 2020 LEMOSYS. All rights reserved.
//

import UIKit

class TimeTrackingViewController: UIViewController {
    
    //MARK:- OutLets of the Controller
    @IBOutlet var btnProfile: UIButton!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var tableViewObj: UITableView!
    @IBOutlet var lblTotalTime: UILabel!
    @IBOutlet var btnTimer: UIButton!
    @IBOutlet var btnStop: UIButton!
    
    
    //MARK:- Class Variable
    var countdownTimer: Timer!
    var totalTime = 0
    var minutes = 0
// paused time is the time when user pauses the Timer
    var pausedTime = 0
    
   //This array Stores the Time From The Timer
    var arrOfTime = [Int]()
    
    
    //MARK:- ViewDidLoad of the Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //for removing seperator from TimeTableView
         tableViewObj.separatorStyle = .none
        
        //Start Timer
        startTimer()
        btnTimer.isSelected = true
        btnStop.isSelected  = true
        btnStop.isUserInteractionEnabled = true
        btnTimer.isUserInteractionEnabled = true
        
    }
    
   
    
    //MARK:- IBActions of the Controller
    

  //MARK:- Canlendar IBActions of the Controller
    @IBAction func btnActionCalendar(_ sender: UIButton) {
        
        
    }
    
    //MARK:- Profile IBActions of the Controller
    @IBAction func btnActionProfile(_ sender: UIButton) {
        
    }
    
    //MARK:- Menu IBActions of the Controller
    @IBAction func btnActionMenu(_ sender: UIButton) {
        
        
    }
    
    
    //MARK:- Timer IBActions of the Controller
    @IBAction func btnActionTimerPlay(_ sender: UIButton) {
        
        if btnTimer.isSelected {
            print("Paused Timer")
            btnTimer.isSelected = false
            countdownTimer.invalidate()
            btnStop.isUserInteractionEnabled = false
            btnTimer.setImage(UIImage(named : "TimerPausedButton"), for: .normal)
            
            
        } else {
            print("Start Timer")
            btnTimer.isSelected = true
            btnStop.isUserInteractionEnabled = true
            startTimer() // Start Timer
            btnTimer.setImage(UIImage(named : "TimerPlayButton"), for:  .normal)
            
        }
        
    }
    
    // startTimer Function Declaration here
        func startTimer() {
            print("Timer is start now")
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    
    
    // Function called every time interval from the timer
    @objc func updateTime() {
         if totalTime != 60 {
            totalTime += 1
            pausedTime += 1
            lblTime.text = "\(timeFormatted(totalTime))"
        } else {
            totalTime = 0
        }
        // paused time is the time when user pauses the time
        
    }
    
    // time Formatted Function
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
            minutes = minutes + (totalSeconds / 60) % 60
             let hours: Int = totalSeconds / 3600
        return String(format: "%02d : %02d : %02d",minutes, seconds,hours)
    }
    
    //MARK:- Stop Timer IBActions of the Controller
    @IBAction func btnActionStopTimer(_ sender: UIButton) {
       
        if btnStop.isSelected {
            
           btnStop.isSelected = false
           btnTimer.isUserInteractionEnabled = false
           //StopTimer  Here
           countdownTimer.invalidate()
           btnStop.setTitle("Start", for: .normal)
           lblTime.text = "00 : 00"
           totalTime = 0
            minutes = 0
           btnTimer.setImage(UIImage(named : "TimerPausedButton"), for: .normal)
           //here i'm apending the Time Into The Array
           arrOfTime.append(pausedTime)
           pausedTime = 0
           tableViewObj.reloadData()
            
            // total time calculation
            totalTimeCation()
            

        } else {
            
           btnStop.isSelected = true
           btnTimer.isUserInteractionEnabled = true
           startTimer()// Start Timer
            btnTimer.setImage(UIImage(named : "TimerPlayButton"), for:  .normal)
           btnStop.setTitle("STOP", for: .normal)
        }
       
    }
    
    // function for the total time calculation
    func totalTimeCation () {
        var totalTimeCalculation = 0
        for i in 0..<arrOfTime.count {
             totalTimeCalculation = totalTimeCalculation + arrOfTime[i]
        }
           lblTotalTime.text = "Total Time = \(timeFormatted(totalTimeCalculation))"
            totalTime = 0
              minutes = 0
      }
    
    
    
   //MARK:- Today Job IBActions of the Controller
    @IBAction func btnActionTodayJob(_ sender: UIButton) {
        
        
    }
    
    //MARK:- FutureJob IBActions of the Controller
    @IBAction func btnActionFutureJob(_ sender: UIButton) {
        
        
    }
    
    //MARK:- CompletedJob IBActions of the Controller
    @IBAction func btnActionCompletedJob(_ sender: UIButton) {
        
        
        
    }
    
}

// Extension For The TableView
extension TimeTrackingViewController:UITableViewDelegate,UITableViewDataSource {
   
    //MARK:- Tableview DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let timeCell = tableViewObj.dequeueReusableCell(withIdentifier: "TimeRecordCell", for: indexPath) as! TimeRecordCell
        
        let seconds = arrOfTime[indexPath.row]
        timeCell.lblTitleTime.text = timeFormatted(seconds)
        return timeCell
    }
    
    
    
    
    
}

