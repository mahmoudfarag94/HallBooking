import UIKit

class ReservationViewController: UIViewController {
    
    var id:Int?
    var userid:Int!
    
    
    @IBOutlet weak var PersonNameText:UITextField!
    @IBOutlet weak var hallEvent: UITextField!
    @IBOutlet weak var startDateText: UIDatePicker!
    @IBOutlet weak var endDateText: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reserve Hall"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let (id,_) = Helper.getUserId()!
        userid = id
    }
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func callApi(){
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let sdate = formater.string(from: startDateText.date)
        let edate = formater.string(from: endDateText.date)

        guard let event = hallEvent.text ,!event.isEmpty else {return}
        API.reserveHall(sDate: sdate, eDate: edate, event: event,hallId:id!, userId: userid ) { (error, state, data) in
            let sts = data["status"].bool
            if sts == true{
                let alert = UIAlertController(title: "Hall Booking ", message:"Your resevation success", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style:.default, handler: { (alertAction) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Hall Booking ", message: "resevation failed try again", preferredStyle: .alert)
                let act = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(act)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func PersonClickedReserve(_ sender:UIButton){
        callApi()
        hallEvent.text = ""
    }
}

