//  AppearanceViewController.swift
//  HallBooking
//
//  Created by mahmoud on 10/9/18.
//  Copyright © 2018 mahmoud. All rights reserved.

import UIKit
import NVActivityIndicatorView

class AppearanceViewController: UIViewController {
    
    var userID:Int?
     var indicator:NVActivityIndicatorView!
    var arrayhistory = [History]()
    
    @IBOutlet weak var appearanceTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appearanceTableView.delegate = self
        appearanceTableView.dataSource = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        displayIndicator()
        let (id,_) = Helper.getUserId()!
        userID = id
        callApi()
    }
    
    func displayIndicator(){
        indicator = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 25, y: view.center.y - 25, width: 50, height: 50))
        indicator.color = UIColor(red:0.80, green:0.60, blue:0.40, alpha:1.0)
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func callApi(){
        API.historyHall(userId: userID!) { (error, state, data) in
            let st = data["status"].bool!
            if st == true {
               let hal = DataFormater.getHistoryHall(_data: data)
                self.arrayhistory = hal
                self.appearanceTableView.reloadData()
            }
            print(data)
        }
    }
}

extension AppearanceViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayhistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyCell = appearanceTableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath)as! HistoryTableViewCell
        let currentHall = arrayhistory[indexPath.row]
        let _confirm = String(currentHall.confirm ?? 0)
        
        historyCell.getHistroyDetail(eventName: currentHall.event!,/* creationDate: "", */confirm: _confirm, cancel: currentHall.cancel!)
    
        indicator.removeFromSuperview()
        indicator.stopAnimating()
        indicator.isHidden = true
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appearanceTableView.deselectRow(at: indexPath, animated: true)
        let detailHistoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "histoDetail") as! HistoryDetailViewController
        detailHistoVC.historyDetail = arrayhistory[indexPath.row]
        self.navigationController?.pushViewController(detailHistoVC, animated: true)
    }
    
}
