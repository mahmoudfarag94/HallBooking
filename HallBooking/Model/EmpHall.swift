import Foundation

class EmpHall {
    
    var hallId:Int?
    var hallName:String?
    var hallAddress:String?
    var hallCapacity:Int?
    var hallState:Int?
    var hallMini:Int?
    var hallLastReservation:String?
    var reservedHall:[ReservationHallModel]?
    
init(hallId:Int,hallName:String,hallAddress:String,hallCapacity:Int,hallState:Int,hallMini:Int,hallLastReservation:String,reservedHall:[ReservationHallModel]) {
        self.hallId = hallId
        self.hallName = hallName
        self.hallAddress = hallAddress
        self.hallCapacity = hallCapacity
        self.hallState = hallState
        self.hallMini = hallMini
        self.hallLastReservation = hallLastReservation
        self.reservedHall = reservedHall
    }
    
//    init(hallId:Int,hallName:String,hallAddress:String,hallCapacity:Int,hallMini:Int,reservation:[ReservationHallModel]){
//        self.hallId = hallId
//        self.hallName = hallName
//        self.hallAddress = hallAddress
//        self.hallCapacity = hallCapacity
//        self.hallMini = hallMini
//        self.reservedHall = reservation
//    }
//    
//    init(reservation:[ReservationHallModel]){
//        self.reservedHall = reservation
//    }
}
