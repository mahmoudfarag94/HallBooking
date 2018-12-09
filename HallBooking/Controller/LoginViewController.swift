import UIKit
import SwiftyJSON
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getUserData(){
        guard let email = emailtext.text,!email.isEmpty else {return}
        guard let password = passwordText.text , !password.isEmpty else {return}
        API.login(email: email, password: password) { (error, state,data) in
        
            let status = data["status"].bool
            if status == true{
                let type = data["data"]["user"]["role"]["role"].string!
                let id = data["data"]["user"]["id"].int!
                if type == "user"{
                    
                    Helper.saveUserId(id: id, role: type)
                    let userHallVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userTabBar")
                    self.present(userHallVC, animated: true, completion: nil)
                    
                }else if type == "employee"{
                    
                    Helper.saveUserId(id: id, role: type)
                    let empHallVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "empTabBar")
                    self.present(empHallVC, animated: true, completion: nil)
                    
                }else{
                    
                    Helper.saveUserId(id: id, role: type)
                    let adminHallVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adminNav")
                    self.present(adminHallVC, animated: true, completion: nil)
                }
            }
            
            let userAlert = UIAlertController(title: "Hall Booking", message: "incorrect UserName or Password", preferredStyle: .alert)
            let userAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.emailtext.text = ""
                self.passwordText.text = ""
                return
            })
            userAlert.addAction(userAction)
            self.present(userAlert, animated: true, completion: nil)
        }
    }
   
    @IBAction func LoginClicked(_ sender:UIButton){
        getUserData()
    }
    
    @IBAction func signUp(_ sender:UIButton){
        let registerVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "registerview")as!RegisterViewController
        registerVC.flage = 1
        registerVC.roleId = 1
       self.present(registerVC, animated: true, completion: nil)
    }
}
