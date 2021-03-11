//
//  BuyItemViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 09.03.2021.
//

import UIKit

class BuyItemViewController: UIViewController, UITextFieldDelegate {
    
    
    // Outlet
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    //Variable
    
    var nameItem : String!
    
    override func viewDidLoad() {
        self.cardNumber.delegate = self
        self.date.delegate = self
        self.cvv.delegate = self
        self.email.delegate = self
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController!.navigationBar.topItem!.title = "Back"
        productName.text = nameItem
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cardNumber.resignFirstResponder()
        date.resignFirstResponder()
        cvv.resignFirstResponder()
        email.resignFirstResponder()
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
