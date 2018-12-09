import Foundation
import SwiftyJSON

class DataFormater:NSObject {
    
    // get user hall data .
    class func getHallData(_data:JSON) -> Array<Hall>{
        var arrayHalls = [Hall]()
        var arrayImage = [String]()
        var lastReservation:String?
        let jsonHall = _data["data"]["halls"].array
        for hall in jsonHall!{
            let id = hall["id"].int!
            let name = hall["name"].string!
            let address = hall["address"].string!
            let capacity = hall["capacity"].int!
            let mini = hall["min_capacity"].int!
            let available = hall["available"].int!
            if let lastReserv = hall["last_reserved"].string{
                lastReservation = lastReserv
            }else{
                lastReservation = "no specific time"
            }
            let imgArray = hall["images"].array
            for img in imgArray!{
                let path = img["path"].string
                arrayImage.append(path!)
                print("path is :- \(path!)")
                print("first")
            }
            let hall = Hall(hallId:id,hallName: name, hallAddress: address, hallCapacity: capacity, hallMini: mini, availability: available, hallLastReservation: lastReservation!, hallImage: arrayImage)
            arrayHalls.append(hall)
        }
        return arrayHalls
    }
    
    class func getHistoryHall(_data:JSON)->Array<History>{
        var historyArray = [History]()
        let data = _data["data"]["reservations"].array
        for hall in data!{
            let event = hall["event"].string!
            let cancel:String?
            if let cancelled = hall["cancelled_at"].string{
                cancel = cancelled
            }else{
                cancel = ""
            }
            let confirmed = hall["confirmed"].int!
            let sDate = hall["from_datetime"].string!
            let eDate = hall["to_datetime"].string!
            let hallid = hall["hall"]["id"].int!
            let halName = hall["hall"]["name"].string!
            let address = hall["hall"]["address"].string!
            let capacity = hall["hall"]["capacity"].int!
            let min_capacity = hall["hall"]["min_capacity"].int!
            let available = hall["hall"]["available"].int!
            
            let his = History(event: event, confirm: confirmed, cancel: cancel!, beginDate: sDate, endDate: eDate, hallname: halName, hallid: hallid, capacity: capacity, mini: min_capacity, available: available, address: address)
            historyArray.append(his)
        }
        return historyArray
    }
    
    class func getUserData(data:JSON)-> UserModel{

        var objData:UserModel!
        let username = data["data"]["user"]["username"].string!
        let fullname = data["data"]["user"]["full_name"].string!
        let userPhone:String?
        
        if let phone = data["data"]["user"]["phone"].string{
            userPhone = phone
        }
        else{
            userPhone = "plz insert your phone"
        }
        let email = data["data"]["user"]["email"].string!
        let add:String?
        if let address = data["data"]["user"]["address"].string{
            add = address
        }else{
            add = ""
        }
        
        let userData = UserModel(username: username, fullName: fullname, userAddress: add!, userEmail: email, userPhone: userPhone!)
        objData = userData
        return objData
    }
    
    // to get All halls to Employee
    class func getAllHallData(_data:JSON)->Array<EmpHall>{
        
        var hallsArr = [EmpHall]()
        var reservHallArr = [ReservationHallModel]()
        
        var lastReservation:String?
        let jsonAllHall = _data["data"]["halls"].array
        for hall in jsonAllHall!{
            let hallId = hall["id"].int!
            let hallName = hall["name"].string!
            let address = hall["address"].string!
            let capacity = hall["capacity"].int!
            let min_capacity = hall["min_capacity"].int!
            let available = hall["available"].int!
            if let lastReserv = hall["last_reserved"].string{
                lastReservation = lastReserv
            }else{
                lastReservation = "no specific time"
            }
            let allReservation = hall["reservations"].array
            
                for reservedHall in allReservation!{
                    let event = reservedHall["event"].string!
                    let from_datetime = reservedHall["from_datetime"].string!
                    let to_datetime = reservedHall["to_datetime"].string!
                    
                    let userName = reservedHall["user"]["username"].string!
                    let fullName = reservedHall["user"]["full_name"].string!
                    let userAddress = reservedHall["user"]["address"].string!
                    let _userPhone:String?
                    if let userphone = reservedHall["user"]["phone"].string{
                        _userPhone = userphone
                    }else{
                        _userPhone = "not have Phone number"
                    }
                    let userEmail = reservedHall["user"]["email"].string!
                    let user = UserModel(username: userName, fullName: fullName, userAddress: userAddress, userEmail: userEmail, userPhone: _userPhone!)
                    //print(userName , fullName , userAddress , userEmail , _userPhone!)
                    let resHall = ReservationHallModel(hallEvent: event, hallStartDate: from_datetime, hallEndDate: to_datetime, userData:user)
                    reservHallArr.append(resHall)
                }
                let reservedHall = EmpHall(hallId:hallId,hallName: hallName, hallAddress: address, hallCapacity: capacity, hallState: available, hallMini: min_capacity, hallLastReservation: lastReservation!, reservedHall: reservHallArr)
                hallsArr.append(reservedHall)
                reservHallArr.removeAll()
            
        }
        return hallsArr
    }
    
    
    // get pending hall data .
    class func getPendingHallData (_data:JSON) -> Array<PendingHall>{
        var pendingHallArray = [PendingHall]()
        let jsonPendHall = _data["data"]["reservations"].array
        
        for pendHall in jsonPendHall!{
            
            let hallname = pendHall["hall"]["name"].string!
            let hallcapacity = pendHall["hall"]["capacity"].int!
            let halladdress = pendHall["hall"]["address"].string!
            let min_capacity = pendHall["hall"]["min_capacity"].int!
            let available = pendHall["hall"]["available"].int!
            let last:String!
            if let last_reserved = pendHall["hall"]["last_reserved"].string{
                last = last_reserved
            }else{
                last = ""
            }
            
            let event = pendHall["event"].string!
            let resId = pendHall["id"].int!
            let stDate = pendHall["from_datetime"].string!
            let endDate = pendHall["to_datetime"].string!
            
            let user = pendHall["user"]["username"].string!
            let fullName = pendHall["user"]["full_name"].string!
            let userAddress = pendHall["user"]["address"].string!
            let email = pendHall["user"]["email"].string!
            let userPhone:String?
            if let phone = pendHall["user"]["phone"].string {
                userPhone  = phone
            }else{
                userPhone = "unavailable"
            }
            
            let hallPend = PendingHall(hallName: hallname, hallAddress: halladdress, hallCapacity: hallcapacity, hallState: available, hallMini: min_capacity, hallLastReservation: last, resId: resId,hallEvent:event, hallStartDate: stDate, hallEndDate: endDate, username: user, fullName: fullName, userAddress: userAddress, userEmail: email, userPhone: userPhone!)
            pendingHallArray.append(hallPend)
        }
        return pendingHallArray
    }
    
    class func getRoleId(data:JSON)->Array<Int>{
        let roleIdarray = [Int]()
        let data = data["data"]["roles"].array!
        for id in data{
            let roelId = id["id"].int!
            print(roelId)
        }
        return roleIdarray
    }
    
}
