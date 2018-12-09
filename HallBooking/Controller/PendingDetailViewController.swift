//
//  PendingDetailViewController.swift
//  HallBooking
//
//  Created by mahmoud on 10/30/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit

class PendingDetailViewController: UIViewController {
    
    
    var data:PendingHall?
    
    @IBOutlet weak var hallName:UILabel!
    @IBOutlet weak var hallAddress:UILabel!
    @IBOutlet weak var hallcapacity:UILabel!
    @IBOutlet weak var hallMini:UILabel!
    @IBOutlet weak var hallState:UILabel!
    @IBOutlet weak var EventName:UILabel!
    @IBOutlet weak var sDate:UILabel!
    @IBOutlet weak var eDate:UILabel!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userEmail:UILabel!
    @IBOutlet weak var userAddress:UILabel!
    @IBOutlet weak var userPhone:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullDetail()
        navigationItem.title = "Detail"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    func fullDetail(){
        hallName.text = data?.hallName
        hallAddress.text = data?.hallAddress
        let cap = String(data?.hallCapacity  ?? 0 )
        let mini = String(data?.hallMini ?? 0)
        hallcapacity.text = cap
        hallMini.text = mini
        EventName.text = data?.hallEvent
        sDate.text = data?.hallStartDate
        eDate.text = data?.hallEndDate
        userName.text = data?.username
        userEmail.text = data?.userEmail
        userAddress.text = data?.userAddress
        userPhone.text = data?.userPhone
    }
    
    
    
    
}
