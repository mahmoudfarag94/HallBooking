import Foundation

class ReservationHallModel {
    
    var hallEvent:String?
    var hallStartDate:String?
    var hallEndDate:String?
    var userData:UserModel?
    
    init(hallEvent:String,hallStartDate:String,hallEndDate:String,userData:UserModel){
        self.hallEvent = hallEvent
        self.hallStartDate = hallStartDate
        self.hallEndDate = hallEndDate
        self.userData = userData
    }
    
//    init(hallEvent:String,hallStartDate:String,hallEndDate:String){
//        self.hallEvent = hallEvent
//        self.hallStartDate = hallStartDate
//        self.hallEndDate = hallEndDate
//
//    }
    
}
