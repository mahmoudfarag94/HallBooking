
import UIKit
import DropDown

class AddminReservationViewController: UIViewController {

    var pendingArray = [PendingHall]()
    
    @IBOutlet weak var adminTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        navigationItem.title = "Pending Halls"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func addEmp(_ sender:UIBarButtonItem){
        drop()
    }
    
//    func callapiRole(){
//        API.getRoleId { (error, state, data) in
//            let st = data["status"].bool!
//            if st == true {
//              let role = DataFormater.getRoleId(data: data)
//            }
//        }
//    }
    
    func drop(){
        let dropdown = DropDown()
        dropdown.anchorView = navigationItem.rightBarButtonItem
        dropdown.dataSource = ["Add Employee","Add Addmine"]
        dropdown.width = 150
        dropdown.show()
        dropdown.topOffset = CGPoint(x: 0, y:-(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                let addEmpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerview")as! RegisterViewController
                addEmpVC.flage = 2
                addEmpVC.roleId = 3
                self.navigationController?.pushViewController(addEmpVC, animated: true)
            }else{
                let addAdminVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerview")as! RegisterViewController
                addAdminVC.flage = 3
                addAdminVC.roleId = 2
                self.navigationController?.pushViewController(addAdminVC, animated: true)
            }
        }
        
    }
    func callApi(){
        API.pendingHall { (error, state, data) in
            let st = data["status"].bool
            if st == true{
                let pHall = DataFormater.getPendingHallData(_data: data)
                self.pendingArray = pHall
                self.adminTableView.reloadData()
            }else{
                self.reloadData()
            }
        }
    }
    
    func reloadData(){
        let reloadAlert = UIAlertController(title: "Hall Booking", message: "Click OK To Reload Data", preferredStyle: .alert)
        let act = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.callApi()
        })
        reloadAlert.addAction(act)
        self.present(reloadAlert, animated: true, completion: nil)
    }
    
}
extension AddminReservationViewController:Confirmable{
    
    func calApiConfirm(id:Int) {
        API.AcceptHalls(confirmId: id) { (error, state, data) in
            let st = data["status"].bool
            
            if st == true{
                // let id = data["reservation"]["id"].int!
                print(data)
            }
        }
    }
    
    func calApiCancel(id:Int) {
        API.cancelHalls(cancelId: id) { (error, state, data) in
            let st = data["status"].bool
            
            if st == true{
                // let id = data["reservation"]["id"].int!
                print(data)
            }
        }
    }
    
    func confirme(index: Int) {
        calApiConfirm(id: index)
    }
    
    func cancel(index: Int) {
        calApiCancel(id: index)
    }
}

extension AddminReservationViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pendCell = adminTableView.dequeueReusableCell(withIdentifier: "pendingCell", for: indexPath) as! pendingCell
        
        pendCell.correctButton.tag = pendingArray[indexPath.row].resId!
        pendCell.incorrectButton.tag = pendingArray[indexPath.row].resId!
        pendCell.confirmationDelegate = self
        
        let pendHall = pendingArray[indexPath.row]
        let st = String(pendHall.hallState ?? 0)
        pendCell.getData(name: pendHall.hallName!, startdate: pendHall.hallStartDate!, endDate: pendHall.hallEndDate!, state: st)
        return pendCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        adminTableView.deselectRow(at: indexPath, animated: true)
        let detailVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pendingDetail") as! PendingDetailViewController
        detailVC.data = pendingArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
