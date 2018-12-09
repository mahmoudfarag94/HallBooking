import UIKit

protocol HallReservable {
    func reserve(index:Int)
}

class HallTableViewCell: UITableViewCell {
    
    var hallReserveDelegate:HallReservable?
    
    @IBOutlet weak var hallsName:UILabel!
    @IBOutlet weak var hallsCapacity:UILabel!
    @IBOutlet weak var hallsAvailable:UILabel!
    @IBOutlet weak var hallsImageAvailable:UIImageView!
    @IBOutlet weak var reserveHallButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getHallData(name:String,capacity:String,available:String){
        hallsName.text = name
        hallsCapacity.text = capacity
        let av = available
        if av == String("0"){
            hallsImageAvailable.image = UIImage(named:"unAvailable")
            hallsAvailable.text = "Not Available"
        }else{
           hallsImageAvailable.image = UIImage(named: "available")
            hallsAvailable.text = "available"
        }
    }
    
    @IBAction func Reserve(_ sender:UIButton){
        hallReserveDelegate?.reserve(index: sender.tag)
    }
}
