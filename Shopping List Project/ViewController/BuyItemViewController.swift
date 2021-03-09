//
//  BuyItemViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 09.03.2021.
//

import UIKit

class BuyItemViewController: UIViewController {
    
    
    // Outlet
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    //Variable
    
    var nameItem : String!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.tabBarController?.tabBar.isHidden = true

         productName.text = nameItem
        //print(productName.text)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buyButtonTap(_ sender: Any) {
        if let bankCardNumber = cardNumber.text, !bankCardNumber.isEmpty,
           let bankCardDate = date.text, !bankCardDate.isEmpty,
           let securityCard = cvv.text, !securityCard.isEmpty,
           let userEmail = email.text, !userEmail.isEmpty {
            
            let alert = UIAlertController(title: "Shopping is Sucess", message: "Thanks for shopping", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "error", message: "Please fill out all required fields", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
        return
    }
    

}
