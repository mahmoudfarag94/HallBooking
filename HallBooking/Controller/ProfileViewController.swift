//  ProfileViewController.swift
//  HallBooking
//
//  Created by mahmoud on 10/28/18.
//  Copyright © 2018 mahmoud. All rights reserved.


import UIKit
import NVActivityIndicatorView

class ProfileViewController: UIViewController {

    var userInfodata:UserModel!
    var indicator:NVActivityIndicatorView!
    var vc:UIView!
    
    @IBOutlet weak var userNameLable:UILabel!
    @IBOutlet weak var fullNameLable:UILabel!
    @IBOutlet weak var emailLable:UILabel!
    @IBOutlet weak var phoneLable:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        displayIndicator()
        let (id , _) = Helper.getUserId()!
        callApi(userId: id)
    }
    
    func callApi(userId:Int){
        API.UserInfoApi(id: userId) { (error, state, data) in
            let st = data["status"].bool
            if st == true{
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
                
                self.userInfodata = DataFormater.getUserData(data: data)
                self.setUserData()
            }
        }
    }
    func displayIndicator(){
        indicator = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 25, y: view.center.y - 25, width: 50, height: 50))
        indicator.color = UIColor(red:0.60, green:0.00, blue:0.00, alpha:1.0)
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    func setUserData(){
        indicator.stopAnimating()
        indicator.isHidden = true
        indicator.removeFromSuperview()
        userNameLable.text = userInfodata.username
        fullNameLable.text = userInfodata.fullName
        emailLable.text = userInfodata.userEmail
        phoneLable.text = userInfodata.userPhone
        
    }
    
    @IBAction func updateUserInfo(_ sender:UIButton){

        let registerVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "registerview")as! RegisterViewController
        registerVC.flage = 0
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
