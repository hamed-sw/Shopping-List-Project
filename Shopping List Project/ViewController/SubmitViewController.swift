//
//  SubmitViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 25.03.2021.
//

import UIKit

class SubmitViewController: UIViewController, UITextViewDelegate {


    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = KeyString.YourFeedback.localizableString()
        }
    }
    @IBOutlet weak var fetbackHere: UITextView! {
        didSet{
            fetbackHere.text = KeyString.placeholderFetback.localizableString()
            fetbackHere.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var submitbtn: UIButton! {
        didSet {
            submitbtn.setTitle(KeyString.Submit.localizableString(), for: .normal)
        }
    }
    
    
    lazy var viewModel = FetbackModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetbackHere.delegate = self
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if fetbackHere.textColor == UIColor.lightGray {
            fetbackHere.text = nil
            fetbackHere.textColor = UIColor.black
        }
    }

    @IBAction func submitBtnTap(_ sender: UIButton) {
        if fetbackHere.text != nil && fetbackHere.textColor == UIColor.lightGray {
            alert(title: KeyString.error.localizableString(), massage: KeyString.pleaseEnter.localizableString())
        }else if fetbackHere.text == ""  && fetbackHere.textColor == UIColor.black {
            alert(title: KeyString.error.localizableString(), massage: KeyString.pleaseEnter.localizableString())
        } else {
            viewModel.insertFetback(insert: fetbackHere.text, forBool: false)
            fetbackHere.text = nil
            alert(title: KeyString.fedback.localizableString(), massage: KeyString.addFeedBack.localizableString())
        }
    }
    func alert(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

}
