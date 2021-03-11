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
        textFiledClears()
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController!.navigationBar.topItem!.title = "Back"
        productName.text = nameItem
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cardNumber.resignFirstResponder()
        date.resignFirstResponder()
        cvv.resignFirstResponder()
        email.resignFirstResponder()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    func textFiledClears() {
        cardNumber.clearButtonMode = .always
        date.clearButtonMode = .always
        cvv.clearButtonMode = .always
        email.clearButtonMode = .always

        cardNumber.clearButtonMode = .whileEditing
        date.clearButtonMode = .whileEditing
        cvv.clearButtonMode = .whileEditing
        email.clearButtonMode = .whileEditing

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
            cardNumber.text = ""
            cvv.text = ""
            email.text = ""
            date.text = ""
            return
        }
        
        alertFunction(error: "Error", massege: "Please fill out all required fields")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder() // dismiss keyboard
         return true
     }

    
    func alertFunction(error: String, massege: String) {
        
        let alert = UIAlertController(title: error , message: massege, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    
    
    
}
