//
//  HomeTableViewCell.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit

protocol TableCellDelegate: class {
    func checkAndUpdate(cell: HomeTableViewCell)
}

class HomeTableViewCell: UITableViewCell {
    
    //Outlet
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameOfProductLabel: UILabel!
    @IBOutlet weak var priceOfProductLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var likeProductButton: UIButton! {
        didSet {
            likeProductButton.setTitle(ButtonImages.unlikeButton, for: .normal)
        }
    }
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    
    // Variable
    var buttonPressed : (() -> ()) = {}
    var buttonLikeAndUnlike : (() -> ()) = {}
    
    let homeVC = HomeViewController()
    weak var delegate: TableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func addCardButtonTap(_ sender: Any) {
        buttonPressed()
    }
    @IBAction func likeProductButtonTap(_ sender: Any) {
        buttonLikeAndUnlike()
        
        
        if likeProductButton.imageView?.image == UIImage(systemName: ButtonImages.unlikeButton){
            likeProductButton.setImage(UIImage(systemName: ButtonImages.likeButton ), for: .normal)
            numberOfLikeLabel.text = "1"
            
        }else {
            likeProductButton.setImage(UIImage(systemName: ButtonImages.unlikeButton), for: .normal)
            numberOfLikeLabel.text = "0"
            
        }
    }
    

    
    
    
}
