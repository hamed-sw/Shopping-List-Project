//
//  TrashbinTableViewCell.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 26.03.2021.
//

import UIKit

class TrashbinTableViewCell: UITableViewCell {

    @IBOutlet weak var trashcell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
