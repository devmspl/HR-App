//
//  ApplicantsDetailVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 26/05/22.
//

import UIKit

class ApplicantsDetailVC: UIViewController {

    
    @IBOutlet weak var applicantName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var shrtName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var jobType: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var skillDescription: UILabel!
    @IBOutlet weak var cvResumeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onViewCVTap(_ sender: UIButton){
        
    }
    
}
