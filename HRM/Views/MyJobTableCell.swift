//
//  InterviewTableCell.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyJobTableCell: UITableViewCell {

    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var salaryAndLocation: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var deleteJob: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
