import UIKit

class DeatailPendCell: UITableViewCell {

    @IBOutlet weak var eventLable:UILabel!
    @IBOutlet weak var creationDatelable:UILabel!
    @IBOutlet weak var SDateLable:UILabel!
    @IBOutlet weak var EndDateLable:UILabel!
    
    
    func getDetailData(eventName:String, CreationDate:String, startDate:String, endDate:String){
        eventLable.text = eventName
        creationDatelable.text = CreationDate
        SDateLable.text = startDate
        EndDateLable.text = endDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
