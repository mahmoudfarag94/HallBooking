
import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    var roleId:Int?
    var flage:Int?
    var _id:Int!
    
    @IBOutlet weak var userNameText:UITextField!
    @IBOutlet weak var userFullNametext:UITextField!
    @IBOutlet weak var userEmailtext:UITextField!
    @IBOutlet weak var userPhoneText:UITextField!
    @IBOutlet weak var userPasswordText:UITextField!
    @IBOutlet weak var addressText:UITextField!
    @IBOutlet weak var button:UIButton!
    
    //        let username:String?
    //        let fullname:String?
    //         let email:String?
    //        let phone:String?
    //        let pass:String?
    //let address:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if flage == 0{
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target: self, action: #selector(goBack))
            navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            navigationItem.title = "Update UserInfo"
            let (id,_) = Helper.getUserId()!
            _id = id
            button.setTitle("Update", for: .normal)
        }else if flage == 2 {
            button.setTitle("Add Emoplyee", for: .normal)
        }else if flage == 3 {
            button.setTitle("Add Admin", for: .normal)
        }else{
            button.setTitle("Register", for: .normal)
        }
        
    }
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func newRegister(roleId:Int){
        guard let username = userNameText.text , !username.isEmpty else {return}
        guard let fullname = userFullNametext.text , !fullname.isEmpty else {return}
        guard let email = userEmailtext.text , !email.isEmpty else {return}
        guard let phone = userPhoneText.text ,!phone.isEmpty else {return}
        guard let pass = userPasswordText.text , !pass.isEmpty   else {return}
        guard let address = addressText.text , !address.isEmpty else{return}
        
        API.register(userName: username, fullName: fullname, email: email, password: pass, address: address, phone: phone, role: roleId) { (error, stat, data) in
            let stat = data["status"].bool
            if stat == true{
                self.navigationController?.popViewController(animated: true)
            }else{
                let userAlert = UIAlertController(title: "Hall Booking", message: "incorrect UserName or Password", preferredStyle: .alert)
                let userAction = UIAlertAction(title:"OK", style: .default, handler: nil)
                userAlert.addAction(userAction)
                self.present(userAlert, animated: true, completion: nil)
            }
    }
    }
    
    func updateUser(){
        //            API.updateUserData(userId:_id, userName: username, fullName: fullname, email: email, password: pass, address: address, phone: phone, role: roleId!) { (error, stat, data) in
        //                let stat = data["status"].bool
        //                if stat == true{
        //                    let userAlert = UIAlertController(title: "Hall Booking", message: "updated", preferredStyle: .alert)
        //                    let userAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        //                        self.navigationController?.popToRootViewController(animated: true)
        //                    })
        //                    userAlert.addAction(userAction)
        //                    self.present(userAlert, animated: true, completion: nil)
        //                }else{
        //                    let userAlert = UIAlertController(title: "Hall Booking", message: "incorrect UserName or Password", preferredStyle: .alert)
        //                    let userAction = UIAlertAction(title:"OK", style: .default, handler: nil)
        //                    userAlert.addAction(userAction)
        //                    self.present(userAlert, animated: true, completion: nil)
        //                }
    }
    
    func checkRegisterData(){
      
        if flage == 0 {
            updateUser()
        }else if flage == 1 {
            newRegister(roleId: roleId!)
        }else if flage == 2{
            newRegister(roleId: roleId!)
        }else if flage == 3{
            newRegister(roleId: roleId!)
        }
    }
    
    @IBAction func RegisterClicked(_ sender:UIButton){
        checkRegisterData()
        userNameText.text = ""
        userFullNametext.text = ""
        userEmailtext.text = ""
        userPasswordText.text = ""
        addressText.text = ""
        userPhoneText.text = ""
    }
}
