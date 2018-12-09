
import UIKit

class UserDeatilViewController: UIViewController {
    
    var userData:ReservationHallModel!
    
    
    @IBOutlet weak var eventNameLable:UILabel!
    @IBOutlet weak var fromDateLable:UILabel!
    @IBOutlet weak var toDateLable:UILabel!
    @IBOutlet weak var userNameLable:UILabel!
    @IBOutlet weak var userEmailLable:UILabel!
    @IBOutlet weak var userAddressLable:UILabel!
    @IBOutlet weak var userPhoneLable:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetail()
        backbarAppearance()
    }
}

extension UserDeatilViewController{
    func backbarAppearance(){
        navigationItem.title = "Detail"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target:self , action:#selector(backBarTabed) )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    func setDetail(){
        eventNameLable.text = userData.hallEvent!
        fromDateLable.text = userData.hallStartDate
        toDateLable.text = userData.hallEndDate
        userNameLable.text = userData.userData?.username
        userEmailLable.text = userData.userData?.userEmail
        userAddressLable.text = userData.userData?.userAddress
        userPhoneLable.text = userData.userData?.userPhone
    }
    
    @objc func backBarTabed(){
        navigationController?.popViewController(animated: true)
    }
    
}
