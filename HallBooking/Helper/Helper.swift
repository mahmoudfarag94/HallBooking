//  Helper.swift
//  HallBooking
//
//  Created by mahmoud on 10/25/18.
//  Copyright © 2018 mahmoud. All rights reserved.

import UIKit

class Helper: NSObject {
    
    class func saveUserId(id:Int , role:String){
        let def = UserDefaults.standard
        def.setValue(id, forKey: "user_id")
        def.setValue(role, forKey: "role")
    }
    
    class func getUserId()->(Int,String)?{
        let def = UserDefaults.standard
        let id = def.object(forKey: "user_id") as? Int
        let role = def.object(forKey: "role") as? String
        return (id!,role!)
    }
    
}
