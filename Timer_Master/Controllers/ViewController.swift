//
//  ViewController.swift
//  Timer_Master
//
//  Created by MacMini104 on 28/01/20.
//  Copyright © 2020 LEMOSYS. All rights reserved.
//

import UIKit

class TimeRecoredCell: UITableViewCell {
    
    @IBOutlet weak var lblTimeRecord: UILabel!
    
}


class  ViewController: UIViewController {
   
    //MARK:- IBOutlets  of the Controller
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var tableViewObj: UITableView!
    @IBOutlet weak var lblTotalTime: UILabel!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
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
            btnPause.isSelected = true
            btnStop.isSelected  = true
            btnStop.isUserInteractionEnabled = true
            btnPause.isUserInteractionEnabled = true
            
      
        }
        
    
    
    
    //MARK:- IBActions Of the Controller
    @IBAction func btnActionStartTimer(_ sender: UIButton) {
        
       if btnPause.isSelected {
           print("Paused Timer")
           btnPause.isSelected = false
           countdownTimer.invalidate()
           btnStop.isUserInteractionEnabled = false
           btnPause.setImage(UIImage(named : "TimerPausedButton"), for: .normal)
           
           
       } else {
           print("Start Timer")
           btnPause.isSelected = true
           btnStop.isUserInteractionEnabled = true
           startTimer() // Start Timer
           btnPause.setImage(UIImage(named : "TimerPlayButton"), for:  .normal)
           
       }

    }
    
    @IBAction func btnActionStopTimer(_ sender: UIButton) {
       
        if btnStop.isSelected {
            
           btnStop.isSelected = false
           btnPause.isUserInteractionEnabled = false
           //StopTimer  Here
           countdownTimer.invalidate()
           btnStop.setTitle("Start", for: .normal)
           lblTimer.text = "00 : 00"
           totalTime = 0
            minutes = 0
           btnPause.setImage(UIImage(named : "TimerPausedButton"), for:  .normal)
           //here i'm apending the Time Into The Array
           arrOfTime.append(pausedTime)
           pausedTime = 0
           tableViewObj.reloadData()
            
            // total time calculation
            totalTimeCation()
            

        } else {
            
           btnStop.isSelected = true
           btnPause.isUserInteractionEnabled = true
           startTimer()// Start Timer
           btnPause.setImage(UIImage(named : "TimerPlayButton"), for:  .normal)
           btnStop.setTitle("STOP", for: .normal)
        }
        
    }
    
    
    //MARK:- Custom Function
    
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
               lblTimer.text = "\(timeFormatted(totalTime))"
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
           return String(format: "%02d : %02d : %02d",hours,minutes, seconds)
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
        
}



// Extension For The TableView
extension ViewController:UITableViewDelegate,UITableViewDataSource {
   
    //MARK:- Tableview DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let timeCell = tableViewObj.dequeueReusableCell(withIdentifier: "TimeRecoredCell", for: indexPath) as! TimeRecoredCell
        
        let seconds = arrOfTime[indexPath.row]
        timeCell.lblTimeRecord.text = timeFormatted(seconds)
        return timeCell
    }
    
    
    
    
    
}
