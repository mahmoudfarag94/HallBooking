import UIKit
import SwiftyJSON

class EmpoyeeHallViewController: UIViewController {
    
    var flage:Bool!
    var searchResult = [EmpHall]()
    var hallArray = [EmpHall]()
    
    @IBOutlet weak var employeeHallTableView: UITableView!
    @IBOutlet weak var capacityFilter:CCheckbox!
    @IBOutlet weak var availableFilter:CCheckbox!
    @IBOutlet weak var search:UISearchBar!
    @IBOutlet weak var filterView:UIView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // search.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        callApi()
        hideFilterView()
    }
    
    func callApi(){
        API.allHall { (error, state, data) in
            let st = data["status"].bool
            if st == true{
                let hal = DataFormater.getAllHallData(_data: data)
               self.hallArray = hal
               self.employeeHallTableView.reloadData()
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
    
    @IBAction func AddHall(_ sender:UIBarButtonItem){
        let AddVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addHallView") as! AddHallViewController
        self.navigationController?.pushViewController(AddVC, animated: true)
    }
    
    
    
}

// extension for search bar .
extension EmpoyeeHallViewController:UISearchBarDelegate{
    
    func hideFilterView(){
        filterView.isHidden = true
        filterView.layer.borderWidth = 0.5
        constraint.constant = 0
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterView.isHidden = false
        constraint.constant = 44.5
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterView.isHidden = true
        constraint.constant = 0
    }
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterView.isHidden = true
        constraint.constant = 0
        
        var str:String!
        if searchBar.text == ""{
            //searchBar.placeholder = "please enter text"
        }
        if capacityFilter.isCheckboxSelected {
            str = "?capacity=\(searchBar.text!)"
            getSearchData(str: str)
        }
        if availableFilter.isCheckboxSelected {
            str = "?filter=available"
            getSearchData(str: str)
        }
        if  !(searchBar.text?.isEmpty)!{
            str = "?name=\(searchBar.text!)"
            getSearchData(str: str)
        }
    }
    func getSearchData(str:String){
        API.searchEmpData(searchText: str) { (error, state, data) in
            self.searchResult.removeAll()
            let st = data["status"].bool
            if st == true{
                let hal = DataFormater.getAllHallData(_data: data)
                self.searchResult = hal
                self.flage = true
                self.employeeHallTableView.reloadData()
                self.capacityFilter.isCheckboxSelected = false
                self.availableFilter.isCheckboxSelected = false
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            flage = false
            hallArray.removeAll()
            searchResult.removeAll()
            callApi()
            employeeHallTableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            employeeHallTableView.reloadData()
        }
    }
    
    
}

// extension for tableviewcontroller .
extension EmpoyeeHallViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flage == true {
            return searchResult.count
        }
        
        return hallArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empHallCell = employeeHallTableView.dequeueReusableCell(withIdentifier: "hallCell", for: indexPath) as! HallEmployeeCell
       
        
        if flage == true {
            let searchHall = searchResult[indexPath.row]
            let available = String(searchHall.hallState ?? 0)
            let capacity = String(searchHall.hallCapacity ?? 0)
            empHallCell.setHallData(name: searchHall.hallName!, capacity: capacity, available: available)
        }else{
        let currentHall = hallArray[indexPath.row]
        let _capacity = String(currentHall.hallCapacity ?? 0)
        let _available = String(currentHall.hallState ?? 0)
        
        empHallCell.setHallData(name: currentHall.hallName!, capacity: _capacity, available: _available)
        
        }
        return empHallCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeHallTableView.deselectRow(at: indexPath, animated: true)
        if flage == true {
            let detailVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "empDetail") as! DetailEmpHallViewController
            detailVC.reserveDetail = searchResult[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }else{
        let detailVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "empDetail") as! DetailEmpHallViewController
        detailVC.reserveDetail = hallArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
