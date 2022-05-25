//
//  MyApplicantsTableCell.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyApplicantsTableCell: UITableViewCell {

    @IBOutlet weak var applicatntName: UILabel!
    @IBOutlet weak var apllicationDate: UILabel!
    @IBOutlet weak var applicantsNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
