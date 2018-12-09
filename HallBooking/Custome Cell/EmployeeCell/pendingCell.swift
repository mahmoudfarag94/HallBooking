import UIKit

protocol Confirmable {
    func confirme(index:Int)
    func cancel(index:Int)
}

class pendingCell: UITableViewCell {
    
    var confirmationDelegate:Confirmable?
    
    @IBOutlet weak var nameLable:UILabel!
    @IBOutlet weak var StartDateLable:UILabel!
    @IBOutlet weak var EndDateLable:UILabel!
    @IBOutlet weak var stateImage:UIImageView!
    @IBOutlet weak var correctButton:UIButton!
    @IBOutlet weak var incorrectButton:UIButton!
    
    func getData(name:String,startdate:String,endDate:String,state:String){
        nameLable.text = name
        StartDateLable.text = startdate
        EndDateLable.text = endDate
        if state == String("0"){
            stateImage.image = UIImage(named: "unAvailable")
        }else{
            stateImage.image = UIImage(named: "available")
        }
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        confirmationDelegate!.confirme(index: sender.tag)
        incorrectButton.isEnabled = false
        print(sender.tag)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        confirmationDelegate!.cancel(index:sender.tag)
        correctButton.isEnabled = false
        
        print(sender.tag)
    }
    
}
