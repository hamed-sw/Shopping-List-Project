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
    // Variable
    var buttonPressed : (() -> ()) = {}
    
    let homeVC = HomeViewController()
    weak var delegate: TableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func addCardButtonTap(_ sender: Any) {
       // buttonPressed()
        delegate?.checkAndUpdate(cell: self)
    }
 
}
