//
//  AddViewController.swift
//  HallBooking
//
//  Created by mahmoud on 10/9/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit
import Alamofire

class AddHallViewController: UIViewController {

    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var hallNameText: UITextField!
    @IBOutlet weak var hallAddress: UITextField!
    @IBOutlet weak var hallCapacity:UITextField!
    @IBOutlet weak var hallminiCapacity:UITextField!
    
    var imagePicker:UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Hall"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    func addHall(){
        guard let name = hallNameText.text , !name.isEmpty else{return}
        guard let address = hallAddress.text ,!address.isEmpty else{return}
        guard let cap = hallCapacity.text , !cap.isEmpty else{return}
        guard let miniCap = hallminiCapacity.text ,!miniCap.isEmpty else{return}
        
        //let img = uploadImage(_image: addImage.image!)
        
        API.addHall(hallName: name, hallCapacity: cap, hallMini: miniCap, hallAddress: address) { (error, state, data) in
            let st = data["status"].bool
            if st == true {
                print(data)
                let alert = UIAlertController(title: "Hall Booking", message: "New Hall Added", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                print("not add")
            }
        }
    }
    
//    @IBAction func AddImage(_ sender: UIButton) {
//         imagePicker = UIImagePickerController()
//        imagePicker?.delegate = self
//        present(imagePicker!, animated: true, completion: nil)
//    }

    @IBAction func AddHallClicked(_ sender: UIButton) {
        
        addHall()
        hallNameText.text = ""
        hallAddress.text = ""
        hallCapacity.text = ""
       hallminiCapacity.text = ""
    }
//    func uploadImage(_image:UIImage)->String{
//        let base64String:String?
//        let imagedata = UIImagePNGRepresentation(_image)
//        base64String = imagedata?.base64EncodedString(options:.lineLength64Characters)
//        return base64String!
//    }
}



//extension AddHallViewController :UIImagePickerControllerDelegate , UINavigationControllerDelegate{
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            addImage.image = image
//
//            imagePicker?.dismiss(animated: true, completion: nil)
//        }
//    }

    
    
    
    
    
    
    
    

