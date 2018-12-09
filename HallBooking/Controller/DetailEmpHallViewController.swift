import UIKit

class DetailEmpHallViewController: UIViewController {
    
    var reserveDetail:EmpHall!
    var detailArr = [ReservationHallModel]()
    
    @IBOutlet weak var detailPendTableView:UITableView!
    
    @IBOutlet weak var hallName: UILabel!
    @IBOutlet weak var hallAddress: UILabel!
    @IBOutlet weak var hallCapacity: UILabel!
    @IBOutlet weak var hallMini: UILabel!
    @IBOutlet weak var hallAvailable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backbarAppearance()
        setHallData()
    }
}

extension DetailEmpHallViewController {
    func backbarAppearance(){
        navigationItem.title = "\(reserveDetail.hallName!) Detail"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target:self , action:#selector(backBarTabed) )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    func setHallData(){
        hallName.text = reserveDetail.hallName!
        hallAddress.text = reserveDetail.hallAddress!
        hallCapacity.text = String (reserveDetail.hallCapacity!)
        hallMini.text = String( reserveDetail.hallMini!)
        let _available = String(reserveDetail.hallState!)
        if _available == "0"{
            hallAvailable.text = "No"
        }else{
            hallAvailable.text = "Yes"
        }
        detailArr = reserveDetail.reservedHall!
        
    }
    
    @objc func backBarTabed(){
        navigationController?.popToRootViewController(animated: true)
    }
    
}
// extention for uitableview methods delegate && datasource

extension DetailEmpHallViewController :UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = detailPendTableView.dequeueReusableCell(withIdentifier: "detailPendCell", for: indexPath) as! DeatailPendCell
        let currentReserve = detailArr[indexPath.row]
        
        detailCell.getDetailData(eventName: currentReserve.hallEvent!, CreationDate: "", startDate: currentReserve.hallStartDate!, endDate: currentReserve.hallEndDate!)
        return detailCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailPendTableView.deselectRow(at: indexPath, animated: true)
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userDetail") as! UserDeatilViewController
        detailVC.userData = detailArr[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
