import Foundation

class  Hall {
    
    var hallId:Int?
    var hallName :String?
    var hallAddress:String?
    var hallCapacity:Int?
    var hallMini:Int?
    var available:Int?
    var hallLastReservation:String?
    var hallImage:[String]?
    
    init(hallId:Int,hallName:String,hallAddress:String,hallCapacity:Int,hallMini:Int,availability:Int,hallLastReservation:String, hallImage:[String]) {
        self.hallId = hallId
        self.hallName = hallName
        self.hallAddress = hallAddress
        self.hallCapacity = hallCapacity
        self.hallMini = hallMini
        self.available = availability
        self.hallLastReservation = hallLastReservation
        self.hallImage = hallImage
    }
}
