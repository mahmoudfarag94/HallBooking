//  history.swift
//  HallBooking
//
//  Created by mahmoud on 10/25/18.
//  Copyright © 2018 mahmoud. All rights reserved.


import Foundation

class History {
    var event :String?
    var confirm:Int?
    var cancel:String?
    var beginDate:String?
    var endDate:String?
   // var creationDate:String?
    var hallname:String?
    var hallid:Int?
    var capacity:Int?
    var mini:Int?
    var available:Int?
    var address:String?
    
    
    init(event:String,confirm:Int,cancel:String,beginDate:String,endDate:String, hallname:String,hallid:Int,capacity:Int,mini:Int,available:Int,address:String) {
        self.event = event
        self.confirm = confirm
        self.cancel = cancel
        self.beginDate = beginDate
        self.endDate = endDate
        self.hallname = hallname
        self.hallid = hallid
        self.capacity = capacity
        self.mini = mini
        self.address = address
        self.available = available
    }
    
    
    
    
}
