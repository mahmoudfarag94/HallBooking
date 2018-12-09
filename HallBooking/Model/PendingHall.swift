import Foundation

class PendingHall {
    
    //hall data .
    var hallName:String?
    var hallAddress:String?
    var hallCapacity:Int?
    var hallState:Int?
    var hallMini:Int?
    var hallLastReservation:String?
    
    //reservation data.
    var hallEvent:String?
    var resId:Int?
    var hallStartDate:String?
    var hallEndDate:String?
    
    //user data
    var username:String?
    var fullName:String?
    var userAddress:String?
    var userEmail:String?
    var userPhone:String?
    
    init(hallName:String,hallAddress:String,hallCapacity:Int,hallState:Int,hallMini:Int,hallLastReservation:String,resId:Int,hallEvent:String?,hallStartDate:String,hallEndDate:String,username:String,fullName:String,userAddress:String,userEmail:String,userPhone:String) {
        
        self.hallName = hallName
        self.hallAddress = hallAddress
        self.hallCapacity = hallCapacity
        self.hallState = hallState
        self.hallMini = hallMini
        self.hallLastReservation = hallLastReservation
        self.hallEvent = hallEvent
        self.resId = resId
        self.hallStartDate = hallStartDate
        self.hallEndDate = hallEndDate
        self.username = username
        self.fullName = fullName
        self.userEmail = userEmail
        self.userAddress = userAddress
        self.userPhone = userPhone
    }
}
