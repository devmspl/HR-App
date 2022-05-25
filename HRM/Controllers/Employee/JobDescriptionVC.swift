//
//  JobDescriptionVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit

class JobDescriptionVC: UIViewController {

    @IBOutlet var companyDescriptionView: UIView!
    @IBOutlet weak var jobDescriptionView: UIView!
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var experienceRequired: UILabel!
    @IBOutlet weak var skillsRequired: UILabel!
    @IBOutlet weak var companyDescription: UIButton!
    @IBOutlet weak var descriptionBtn: UIButton!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var jobType: UILabel!
    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var jobLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.addSubview(jobDescriptionView)
    }
    

    @IBAction func jobDescription(_ sender: Any) {
        mainview.addSubview(jobDescriptionView)
    }
    
    @IBAction func onMessageTap(_ sender: Any) {
    }
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onJobApplyTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobApplyVC") as! JobApplyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onCompanyDescription(_ sender: Any) {
        mainview.addSubview(companyDescription)
    }
}
