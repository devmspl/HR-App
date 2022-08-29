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
    
    var applyId = ""
    var userId = ""
    var applicantData = ApplicantModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        applicantDetailApi()
    }
    
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onViewCVTap(_ sender: UIButton){
        let url = "http://34.231.88.85/Human/humanresource_node_backend/assets/files/\(applicantData.resume ?? "")"
        print(url,"svcasdc")
        UIApplication.shared.open(URL(string: url)!)
    }
    
}


extension ApplicantsDetailVC{
    func applicantDetailApi(){
        ApiManager.shared.getAppliedUserDetails(userId: self.userId, applyid: self.applyId) { data, isSuccess in
            if isSuccess{
                self.applicantData = data!
                self.setData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    func setData(){
        self.applicantName.text = "\(applicantData.firstName ?? "") \(applicantData.lastName ?? "")"
//        let initials = applicantName.text!.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "M" }
        let str = applicantName.text!.first?.description.uppercased()
        self.shrtName.text = str!
        self.email.text = applicantData.applyBy?.email
        self.position.text = applicantData.job?.title
        self.jobType.text = applicantData.job?.jobType 
        self.salary.text = "$\(applicantData.job?.priceFrom ?? 2)k-$\(applicantData.job?.priceTo ?? 4)k"
        self.skillDescription.text = applicantData.describe
    }
}
