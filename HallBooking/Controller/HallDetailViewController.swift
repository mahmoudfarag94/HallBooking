import UIKit


class HallDetailViewController: UIViewController {
    
    var currentHall:Hall!
    
    @IBOutlet weak var hallNameLabel:UILabel!
    @IBOutlet weak var hallAddressLabel:UILabel!
    @IBOutlet weak var hallCapacityLabel:UILabel!
    @IBOutlet weak var hallMinimumLabel:UILabel!
    @IBOutlet weak var hallAvailableLabel:UILabel!
    @IBOutlet weak var hallLastResevationLabel:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title =  currentHall?.hallName
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        setHallData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func setHallData (){
        hallNameLabel.text = currentHall.hallName
        hallAddressLabel.text = currentHall.hallAddress
        hallCapacityLabel.text = String(describing: currentHall.hallCapacity!)
        hallMinimumLabel.text = String(describing: currentHall.hallMini!)
        let availablety = String(describing: currentHall.available!)
        if availablety == "0"{
             hallAvailableLabel.text = "No"
        }else{
            hallAvailableLabel.text = "Yes"
        }
        hallLastResevationLabel.text = currentHall.hallLastReservation
    }
    
    @IBAction func ReservationClicked(_ sender:UIButton){
        
        let reservationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "reservationController") as! ReservationViewController
        reservationVC.id = currentHall.hallId
        navigationController?.pushViewController(reservationVC, animated: true)
    }
}






