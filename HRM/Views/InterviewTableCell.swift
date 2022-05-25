//
//  InterviewTableCell.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class InterviewTableCell: UITableViewCell {

    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var dateApplied: UILabel!
    @IBOutlet weak var checkCVBtn: UIButton!
    @IBOutlet weak var cancelInterviewBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
