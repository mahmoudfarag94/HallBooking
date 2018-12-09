//  HistoryTableViewCell.swift
//  HallBooking
//  Created by mahmoud on 10/25/18.
//  Copyright © 2018 mahmoud. All rights reserved.

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLable:UILabel!
    @IBOutlet weak var stateLable:UILabel!
    
    func getHistroyDetail(eventName:String,confirm:String,cancel:String){
        
        eventNameLable.text = eventName
   
        if confirm == "0"{
            stateLable.text = "Waiting"
            stateLable.textColor = UIColor(red:1.00, green:0.60, blue:0.20, alpha:1.0)
        }
        if confirm == "1"{
            stateLable.text = "Accepted"
            stateLable.textColor = UIColor(red:0.20, green:0.60, blue:0.40, alpha:1.0)
        }
        if cancel == ""{
        }else{
            stateLable.text = "Rejected"
            stateLable.textColor = UIColor(red:0.67, green:0.00, blue:0.00, alpha:1.0)
        }
    }
}
