
import Foundation
class UserModel {
    //user data
    var username:String?
    var fullName:String?
    var userAddress:String?
    var userEmail:String?
    var userPhone:String?
    
    init(username:String,fullName:String,userAddress:String,userEmail:String,userPhone:String) {
        self.username = username
        self.fullName = fullName
        self.userEmail = userEmail
        self.userAddress = userAddress
        self.userPhone = userPhone
    }
}
