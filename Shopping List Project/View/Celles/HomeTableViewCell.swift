//
//  HomeTableViewCell.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //Outlet
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameOfProductLabel: UILabel!
    @IBOutlet weak var priceOfProductLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var likeProductButton: UIButton!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    
    
    // Variable

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addCardButtonTap(_ sender: Any) {
    }
    @IBAction func likeProductButtonTap(_ sender: Any) {
    }
    
    
   
    
}
