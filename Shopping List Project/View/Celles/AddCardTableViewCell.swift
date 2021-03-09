//
//  AddCardTableViewCell.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit


class AddCardTableViewCell: UITableViewCell {
    
    // Outlet
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    

   // weak var delegate: dddddddddddelegate?
    var callBackOnButtonLogout: (()->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buyButtonTap(_ sender: Any) {
        //self.delegate?.addd()
        self.callBackOnButtonLogout?()
    
        
        
    }
    @IBAction func checkButtonTap(_ sender: Any) {
        func delet(name: String) {
            let str = name
            let size = str.reversed().firstIndex(of: "/") ?? str.count
                let startWord = str.index(str.endIndex, offsetBy: -size)
                let last = str[startWord...]
                let sss = String(last)
                print (sss)
            
            
            JsonDelete.del(id: sss) { (erro) in
                    if let err = erro {
                        print("errrrrr",err)
                        return
                    }
                    print("delete")
                }
            
            
        }
    }
    
//    func delet(name: String) {
//        let str = name
//        let size = str.reversed().firstIndex(of: "/") ?? str.count
//            let startWord = str.index(str.endIndex, offsetBy: -size)
//            let last = str[startWord...]
//            let sss = String(last)
//            print (sss)
//        
//        
//        JsonDelete.del(id: sss) { (erro) in
//                if let err = erro {
//                    print("errrrrr",err)
//                    return
//                }
//                print("delete")
//            }
//        
//        
//    }
}
