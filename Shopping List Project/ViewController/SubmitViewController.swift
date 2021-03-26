//
//  SubmitViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 25.03.2021.
//

import UIKit

class SubmitViewController: UIViewController, UITextViewDelegate {


    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var fetbackHere: UITextView! {
        didSet{
            fetbackHere.text = "write your fetback here..."
            fetbackHere.textColor = UIColor.lightGray
            
        }
    }
    
    @IBOutlet weak var submitbtn: UIButton!
    
    
    lazy var viewModel = FetbackModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetbackHere.delegate = self
        

        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
       // self.navigationController!.navigationBar.isHidden = true


        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if fetbackHere.textColor == UIColor.lightGray {
            fetbackHere.text = nil
            fetbackHere.textColor = UIColor.black
        }
    }

    @IBAction func submitBtnTap(_ sender: UIButton) {
        viewModel.insertFetback(insert: fetbackHere.text, forBool: false)
        fetbackHere.text = nil
        let alert = UIAlertController(title: "FetBack", message: "Your Fetback Added successfuly", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        }

    
    


}
