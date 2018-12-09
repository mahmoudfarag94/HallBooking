import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class HallViewController: UIViewController {
    
    var indicator:NVActivityIndicatorView!
    var flage:Bool!
    var searchResult = [Hall]()
    var hallsArray = [Hall]()
    
    
    @IBOutlet weak var hallTableView:UITableView!
    @IBOutlet weak var hallSearch:UISearchBar!
    @IBOutlet weak var filterView:UIView!
    @IBOutlet weak var filterViewconstraint: NSLayoutConstraint!
    @IBOutlet weak var filterAvailableButton: CCheckbox!
    @IBOutlet weak var filterCapacityButton:CCheckbox!
    
    //TODO:- call viewDidLoad .
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hallSearch.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        filterView.isHidden = true
        filterViewconstraint.constant = 0
        filterView.layer.borderWidth = 0.5
        callApi()
        displayIndicator()
        
    }
   
    func displayIndicator(){
        indicator = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 25, y: view.center.y - 25, width: 50, height: 50))
        indicator.color = UIColor(red:0.80, green:0.60, blue:0.40, alpha:1.0)
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    //TODO:- available checkbox func where clicked .
    @IBAction func availableButton(_ sender: CCheckbox) {
    }
    
    //TODO:-capacity checkbox func where clicked .
    @IBAction func capacityButton(_ sender: CCheckbox) {
    }
    
    //MARK :-  to geting halls data from service .
    
    func callApi()  {
        API.getHall { (error, state, data) in
            let st = data["status"].bool
            if st == true{
               let hal = DataFormater.getHallData(_data: data)
                self.hallsArray = hal
                self.hallTableView.reloadData()

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

extension HallViewController:HallReservable{
    func reserve(index: Int) {
        let reservationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "reservationController") as! ReservationViewController
        reservationVC.id = index
        navigationController?.pushViewController(reservationVC, animated: true)
    }
}

//MARK:- tableView delegate method .

extension HallViewController:UITableViewDelegate , UITableViewDataSource{
    
    //TODO:- tableView data method .
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flage == true {
            return searchResult.count
        }
        return hallsArray.count
    }
    
    //TODO:- tableView cellForAt method .
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hallsCell = hallTableView.dequeueReusableCell(withIdentifier: "hallCell", for: indexPath) as! HallTableViewCell
        
        hallsCell.hallReserveDelegate = self
        hallsCell.reserveHallButton.tag = hallsArray[indexPath.row].hallId!
        if flage == true {
                let searchHall = searchResult[indexPath.row]
                let available = String(searchHall.available ?? 0)
                let capacity = String(searchHall.hallCapacity ?? 0)
                hallsCell.getHallData(name: searchHall.hallName!, capacity: capacity, available: available)
        }else{
            let hallData = hallsArray[indexPath.row]
            let availabel = String(hallData.available ?? 0)
            let capacity = String(hallData.hallCapacity ?? 0)
            hallsCell.getHallData(name: hallData.hallName!, capacity: capacity, available: availabel)
        }
        indicator.removeFromSuperview()
         indicator.stopAnimating()
        indicator.isHidden = true
        return hallsCell
    }
    
    //TODO:- tableview didSelectedRow .
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hallTableView.deselectRow(at: indexPath, animated: true)
        if searchResult.count > 0 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hallDetail") as! HallDetailViewController
            vc.currentHall = searchResult[indexPath.row]
            navigationController?.pushViewController(vc,animated: true)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hallDetail") as! HallDetailViewController
            vc.currentHall = hallsArray[indexPath.row]
            navigationController?.pushViewController(vc,animated: true)
            
        }
        
        
        
    }
    
    //TODO:- tableview row hieght method .
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK:- uiSearchBar  extension .

extension HallViewController : UISearchBarDelegate{
 
    //TODO:- func to begin editing.
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterView.isHidden = false
        filterViewconstraint.constant = 44.5
    }
    
    //TODO:- func to end editing .
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterView.isHidden = true
        filterViewconstraint.constant = 0
    }
    
    //TODO:- func to starte search .
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterView.isHidden = true
        filterViewconstraint.constant = 0
        
        var str:String!
        if searchBar.text == ""{
            //searchBar.placeholder = "please enter text"
        }
        if filterCapacityButton.isCheckboxSelected {
            str = "?capacity=\(searchBar.text!)"
            getSearchData(str: str)
        }
        if filterAvailableButton.isCheckboxSelected {
            str = "?filter=available"
            getSearchData(str: str)
        }
        if  !(searchBar.text?.isEmpty)!{
            str = "?name=\(searchBar.text!)"
            getSearchData(str: str)
        }
    }
    
    //TODO:- to get result search hall .
    
    func getSearchData(str:String){
        API.searchData(searchText: str) { (error, state, data) in
            self.searchResult.removeAll()
            let st = data["status"].bool
            if st == true{
                let hal = DataFormater.getHallData(_data: data)
                self.searchResult = hal
                self.flage = true
                self.hallTableView.reloadData()
                self.filterCapacityButton.isCheckboxSelected = false
                self.filterAvailableButton.isCheckboxSelected = false
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            flage = false
            hallsArray.removeAll()
            searchResult.removeAll()
            callApi()
            hallTableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            hallTableView.reloadData()
        }
    }
}
