import UIKit

class HallEmployeeCell: UITableViewCell {
    
    @IBOutlet weak var HallName:UILabel!
    @IBOutlet weak var hallCapacity:UILabel!
    @IBOutlet weak var hallImage:UIImageView!
    
    func setHallData (name:String,capacity:String,available:String){
        HallName.text = name
        hallCapacity.text = capacity
        if available == "1"{
            hallImage.image = UIImage(named: "available")
        }else{
            hallImage.image = UIImage(named: "unAvailable")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
