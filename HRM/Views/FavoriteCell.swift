//
//  FavoriteCell.swift
//  HRM
//
//  Created by Macbook Air (ios) on 20/05/22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var favoriteImage:UIImageView!
    @IBOutlet weak var name:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
