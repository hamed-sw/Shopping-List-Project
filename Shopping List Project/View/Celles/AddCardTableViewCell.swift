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

    
    // Variable
    var callBackOnButtonLogout: (()->())?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    @IBAction func buyButtonTap(_ sender: Any) {
        self.callBackOnButtonLogout?()
        
    }
    
    
}
