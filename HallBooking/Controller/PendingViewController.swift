import UIKit
import SwiftyJSON

class PendingViewController: UIViewController {
    
    
    var pendingArray = [PendingHall]()
    
    @IBOutlet weak var pendingTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        navigationItem.title = "Pending Halls"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func callApi(){
        API.pendingHall { (error, state, data) in
            let st = data["status"].bool
            if st == true{
             let pHall = DataFormater.getPendingHallData(_data: data)
                self.pendingArray = pHall
                self.pendingTableView.reloadData()
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
extension PendingViewController:Confirmable{
    
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

extension PendingViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pendCell = pendingTableView.dequeueReusableCell(withIdentifier: "pendingCell", for: indexPath) as! pendingCell
       
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
        pendingTableView.deselectRow(at: indexPath, animated: true)
        let detailVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pendingDetail") as! PendingDetailViewController
        detailVC.data = pendingArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
