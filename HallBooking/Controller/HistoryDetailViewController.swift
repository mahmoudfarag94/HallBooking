//  HistoryDetailViewController.swift
//  HallBooking
//
//  Created by mahmoud on 10/25/18.
//  Copyright © 2018 mahmoud. All rights reserved.

import UIKit
import PassKit
import Stripe


class HistoryDetailViewController: UIViewController{
    

    var historyDetail:History!
    var tok:STPToken!
   
    
    @IBOutlet weak var eventNameLable: UILabel!
    @IBOutlet weak var stadatelable: UILabel!
    @IBOutlet weak var endDateLable: UILabel!
    @IBOutlet weak var stateLable:UILabel!
    @IBOutlet weak var hallnameLable:UILabel!
    @IBOutlet weak var capacitylable:UILabel!
    @IBOutlet weak var miniLable:UILabel!
    @IBOutlet weak var addressLable:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = historyDetail.event!
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"), style: .plain, target: self, action:#selector(back))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        getDetailData()
         let button = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .whiteOutline)
        
    }
    
    
   
    
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    
    func getDetailData(){
        eventNameLable.text =  historyDetail.event
        hallnameLable.text = historyDetail.hallname
        let cap = String(historyDetail.capacity ?? 0)
        capacitylable.text = cap
        let min = String(historyDetail.mini ?? 0)
        miniLable.text = min
        addressLable.text = historyDetail.address
        stadatelable.text = historyDetail.beginDate
        endDateLable.text = historyDetail.endDate
        let _confirmation = historyDetail.confirm
        let _cancelled = historyDetail.cancel
        if _confirmation == 0{
            stateLable.text = "Waiting"
        }
        if _confirmation == 1{
            stateLable.text = "Confirmed"
        }
        if _cancelled == ""{
            
        }else{
           stateLable.text =  "cancelled at \(_cancelled!)"
        }
    }
}

// Apple Pay
extension HistoryDetailViewController:PKPaymentAuthorizationViewControllerDelegate{
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, handler completion: @escaping (PKPaymentRequestShippingMethodUpdate) -> Void) {
    }
    
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
       
        
        STPAPIClient.shared().createToken(with: payment) { (token:STPToken?, error:Error?) in
            self.tok = token
            print("tok is \(self.tok )")
            guard let _token = token , error == nil else{
                return
            }
            
            
            API.payments(token: (token?.tokenId)!, amount: "1000", completion: { (error, state, data) in
                completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
            })
            
            
            
        }
    }
    
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
    
    
    func payWithStripe(){
        
        let merchantId = "merchant.com.edu.self.Eng.HallBooking"
        let paymentNetworkArray = [PKPaymentNetwork.masterCard,.idCredit,.amex,.discover ,.visa]
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: merchantId, country: "US", currency: "USD")
        paymentRequest.supportedNetworks = paymentNetworkArray
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.requiredShippingAddressFields = .all
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "hall resevation", amount: 9)]

        if Stripe.canSubmitPaymentRequest(paymentRequest){
            let paymentAuthorizationController =
               
                PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            paymentAuthorizationController?.delegate = self
            present(paymentAuthorizationController!, animated: true)
        }
    }
    
    @IBAction func applePayButtonClicked(_ sender:UIButton){
        
        payWithStripe()
       
        
        
//        let paymentsRequst =  PKPaymentRequest()
//        let paymentNetworkArray = [PKPaymentNetwork.masterCard,.idCredit,.amex,.discover ,.visa]
//        paymentsRequst.currencyCode = "USD"
//        paymentsRequst.countryCode = "US"
//        paymentsRequst.merchantIdentifier = "merchant.com.edu.self.Eng.HallBooking"
//        paymentsRequst.supportedNetworks = paymentNetworkArray
//        paymentsRequst.merchantCapabilities = .capability3DS
//        paymentsRequst.requiredShippingAddressFields = .all
//        paymentsRequst.paymentSummaryItems = [PKPaymentSummaryItem(label: "hall resevation", amount: 9.99)]
//        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: paymentsRequst)
//        applePayController?.delegate = self
//      
//        self.present(applePayController!, animated: true, completion: nil)
    }
}





