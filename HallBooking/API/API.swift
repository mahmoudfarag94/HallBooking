import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    // get hall data .
//    class func getHallData(_data:JSON) -> Array<Hall>{
//        var lastReservation:String?
//        var arrayHalls = [Hall]()
//        let jsonHall = _data["data"]["halls"].array
//        for hall in jsonHall!{
//            let name = hall["name"].string!
//            let address = hall["address"].string!
//            let capacity = hall["capacity"].int!
//            let mini = hall["min_capacity"].int!
//            let available = hall["available"].int!
//            if let lastReserv = hall["last_reserved"].string{
//                lastReservation = lastReserv
//            }else{
//                lastReservation = "no specific time"
//            }
//            let imgArray = hall["images"].array
//            for img in imgArray!{
//                let path = img["path"].string
//                print("path is :- \(path!)")
//            }
//            let hall = Hall(hallName: name, hallAddress: address, hallCapacity: capacity, hallMini: mini, availability: available, hallLastReservation: lastReservation!, hallImage: "")
//            arrayHalls.append(hall)
//        }
//        return arrayHalls
//    }
    
//    // get pending hall data .
//    
//    class func getPendingHallData (_data:JSON) -> Array<PendingHall>{
//        var pendingHallArray = [PendingHall]()
//        let jsonPendHall = _data["data"]["reservations"].array
//        for pendHall in jsonPendHall!{
//            let hallname = pendHall["hall"]["name"].string!
//            let hallcapacity = pendHall["hall"]["capacity"].int!
//            let halladdress = pendHall["hall"]["address"].string!
//            let min_capacity = pendHall["hall"]["min_capacity"].int!
//            let available = pendHall["hall"]["available"].int!
//            let last_reserved = pendHall["hall"]["last_reserved"].string!
//            let event = pendHall["event"].string!
//            let stDate = pendHall["from_datetime"].string!
//            let endDate = pendHall["to_datetime"].string!
//            let user = pendHall["user"]["username"].string!
//            let fullName = pendHall["user"]["full_name"].string!
//            let userAddress = pendHall["user"]["address"].string!
//            let email = pendHall["user"]["email"].string!
//            let userPhone:String?
//            if let phone = pendHall["user"]["phone"].string {
//                userPhone  = phone
//            }else{
//                userPhone = "unavailable"
//            }
//            let hallPend = PendingHall(hallName: hallname, hallAddress: halladdress, hallCapacity: hallcapacity, hallState: available, hallMini: min_capacity, hallLastReservation: last_reserved,hallEvent:event, hallStartDate: stDate, hallEndDate: endDate, username: user, fullName: fullName, userAddress: userAddress, userEmail: email, userPhone: userPhone!)
//            pendingHallArray.append(hallPend)
//            //pendingArray = pendingHallArray
//            //pendingTableView.reloadData()
//        }
//        return pendingHallArray
//    }
    
    // login func .
    class func login(email:String, password:String,completion:@escaping(_ error:Error?,_ success:Bool,_ data:JSON)->Void){
        let loginURL = "http://numbertaxi.com/halls-reservation/api/login"
        let prameter = ["email":email,"password":password]
        Alamofire.request(loginURL, method: .post, parameters: prameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case.failure(let error):
                completion(error,false, JSON())
            case.success(let value):
                let jsonData = JSON(value)
                completion(nil , true ,jsonData)
            }
        }
    }
    // register func .
    class func register(userName:String,fullName:String,email:String,password:String,address:String,phone:String,role:Int,completion:@escaping (_ error:Error?,_ success:Bool,_ data:JSON)->Void ){
        let registerURL  = "http://numbertaxi.com/halls-reservation/api/register"
        let prams = ["username":userName , "full_name":fullName , "email":email ,"password":password ,"address":address,"phone":phone , "role_id":role] as [String : Any]
        Alamofire.request(registerURL, method: .post, parameters: prams, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                completion(error , false , JSON())
                print(error)
            case.success(let vale):
                let jsonData = JSON(vale)
                completion( nil , true , jsonData)
            }
        }
    }
    
    // get user halls .
    class func getHall(completion:@escaping(_ error:Error? ,_ success:Bool ,_ data:JSON )->Void){
        let hallURL = "http://numbertaxi.com/halls-reservation/api/halls"
        Alamofire.request(hallURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                completion(error,false,JSON())
            case .success(let value):
                let jsonData = JSON(value)
                completion(nil,true,jsonData)
            }
        }
    }
    
    // search on halls .
    class func searchData (searchText:String,completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let searchUrl = "http://numbertaxi.com/halls-reservation/api/halls\(searchText)"
        Alamofire.request(searchUrl).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                completion(error,false,JSON())
            case .success(let value):
                let jsonData = JSON(value)
                completion(nil,true,jsonData)
            }
        }
    }
    
    // search Emp .
    class func searchEmpData (searchText:String,completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let searchUrl = "http://numbertaxi.com/halls-reservation/api/halls-reservations\(searchText)"
        Alamofire.request(searchUrl).responseJSON { (response) in
            switch response.result{
            case.failure(let error):
                completion(error,false,JSON())
            case.success(let value):
                let jsonData = JSON(value)
                completion(nil,true,jsonData)
            }
        }
    }
    
    // get reservad halls
    class func reserveHall(sDate:String,eDate:String,event:String,hallId:Int,userId:Int,completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let reserveUrl = "http://numbertaxi.com/halls-reservation/api/save-reservation"
    
        
        let parameter = ["from_datetime":sDate,"to_datetime":eDate,"event":event,"hall_id":hallId,"user_id":userId] as [String : Any]
        Alamofire.request(reserveUrl, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                case.failure(let error):
                    completion(error,false,JSON())
                case.success(let value):
                    let jsondata = JSON(value)
                    completion(nil,true,jsondata)
                }
        }
    }
    // get history hall
    class func historyHall(userId:Int ,completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let historyUrl = "http://numbertaxi.com/halls-reservation/api/user-reservations/\(userId)"
        Alamofire.request(historyUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case.failure(let error):
                completion(error,false,JSON())
            case.success(let value):
                let jsonData = JSON(value)
                completion(nil,true,jsonData)
            }
        }
    }
    // get user data . 
   class func UserInfoApi(id:Int,completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let userInfoUrl = "http://numbertaxi.com/halls-reservation/api/user/\(id)"
        Alamofire.request(userInfoUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                case.failure(let error):
                    completion(error,false,JSON())
                case.success(let value):
                    let jsonData = JSON(value)
                    completion(nil,true,jsonData)
                }
        }
    }
    class func updateUserData(userId:Int,userName:String,fullName:String,email:String,password:String,address:String,phone:String,role:Int,completion:@escaping (_ error:Error?,_ success:Bool,_ data:JSON)->Void ){
        let updateURL  = "http://numbertaxi.com/halls-reservation/api/save-user"
        let prams = ["username":userName , "full_name":fullName , "email":email ,"password":password ,"address":address,"phone":phone , "role_id":role,"id":userId] as [String : Any]
        Alamofire.request(updateURL, method:.post, parameters: prams, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                completion(error , false , JSON())
                print(error)
            case.success(let vale):
                let jsonData = JSON(vale)
                print(jsonData)
                completion( nil , true , jsonData)
            }
        }
    }
    
    
    // get all halls .
    class func allHall(completion:@escaping(_ error:Error? ,_ state:Bool ,_ data:JSON)->Void){
        let url = "http://numbertaxi.com/halls-reservation/api/halls-reservations"
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case.failure(let error):
                completion(error , false , JSON())
            case.success(let value):
                let jsondata = JSON(value)
                completion(nil, true , jsondata)
            }
        }
    }
    // get pending halls .
    class func pendingHall(completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let pendingUrl = "http://numbertaxi.com/halls-reservation/api/reservations?filter=pending"
        Alamofire.request(pendingUrl).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error,false,JSON())
            case.success(let value):
                let jsonData = JSON(value)
                completion(nil,true,jsonData)
            }
        }
    }
    
    class func AcceptHalls(confirmId:Int,completion:@escaping(_ error:Error?, _ state:Bool, _ data:JSON)->Void){
        let AcceptUrl = "http://numbertaxi.com/halls-reservation/api/confirm-reservation/\(confirmId)"
        Alamofire.request(AcceptUrl, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case.failure(let error):
                    completion(error,false,JSON())
                case.success(let value):
                    let jsonData = JSON(value)
                    completion(nil,true,jsonData)
                }
        }
    }
    
    class func cancelHalls(cancelId:Int,completion:@escaping(_ error:Error?, _ state:Bool, _ data:JSON)->Void){
        let AcceptUrl = "http://numbertaxi.com/halls-reservation/api/cancel-reservation/\(cancelId)"
        Alamofire.request(AcceptUrl, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case.failure(let error):
                    completion(error,false,JSON())
                case.success(let value):
                    let jsonData = JSON(value)
                    completion(nil,true,jsonData)
                }
        }
    }
    
    class func addHall(hallName:String,hallCapacity:String,hallMini:String,hallAddress:String,completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        let addUrl = "http://numbertaxi.com/halls-reservation/api/save-hall"
        let parms = ["name":hallName,"address":hallAddress,"capacity":hallCapacity,"min_capacity":hallMini]
        Alamofire.request(addUrl, method: .post, parameters: parms, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case.failure(let error):
                completion(error,false,JSON())
            case.success(let value):
                let jsonData = JSON(value)
                completion(nil,true,jsonData)
            }
        }
    }
//    class func addEmp(userName:String,fullName:String,email:String,password:String,address:String,phone:String,role:Int,completion:@escaping (_ error:Error?,_ success:Bool,_ data:JSON)->Void ){
//        let updateURL  = "http://numbertaxi.com/halls-reservation/api/register"
//        let prams = ["username":userName , "full_name":fullName , "email":email ,"password":password ,"address":address,"phone":phone , "role_id":role] as [String : Any]
//        Alamofire.request(updateURL, method:.post, parameters: prams, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//            switch response.result{
//            case .failure(let error):
//                completion(error , false , JSON())
//                print(error)
//            case.success(let vale):
//                let jsonData = JSON(vale)
//                print(jsonData)
//                completion( nil , true , jsonData)
//            }
//        }
//    }
    
   class func getRoleId(completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void) {
        let url = "http://numbertaxi.com/halls-reservation/api/roles"
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error, false,JSON())
            case.success(let value):
                let jsondata = JSON(value)
                completion(nil, true, jsondata)
                
            }
        }
    }
   
    class func getHallImage(url:String , completion:@escaping(_ error:Error?,_ state:Bool,_ data:JSON)->Void){
        Alamofire.request(url).responseData(completionHandler: { (response) in
            switch response.result{
            case .failure(let error):
                completion(error,false,JSON())
            case .success(let value):
                let jsonImage = JSON(value)
                completion(nil,true,jsonImage)
            }
        })
        }
    
    class func payments(token:String ,amount:String, completion:@escaping(_ error:Error? ,_ state:Bool ,_ data:JSON)->Void){
        let url = "http://numbertaxi.com/ios/psh.php"
        let parm = ["token":token, "amount":amount]
        Alamofire.request(url, method: .post, parameters: parm, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case.failure(let error):
                completion(error , false , JSON())
            case.success(let value):
                let jsonData = JSON(value)
                completion(nil, true , jsonData)
            }
        }
    }
    
    
        
    }

