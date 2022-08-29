//
//  JobDescriptionVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import ARSLineProgress
import SocketIO

class JobDescriptionVC: UIViewController {
///
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
    
    @IBOutlet weak var planOfAction: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var emailCompany: UILabel!
    @IBOutlet weak var companyContact: UILabel!
    @IBOutlet weak var companyLocation: UILabel!
    
///
    var jobId = ""
    var jobDetails: JobAndCompanyDetailModel?
///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.backgroundColor = UIColor.clear
        companyDescription.bounds = mainview.bounds
        getApiData()
    }
    

    @IBAction func jobDescription(_ sender: Any) {
        jobDescriptionView.isHidden = false

        companyDescription.removeFromSuperview()
    }
    
    @IBAction func onMessageTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.receiptantUser = jobDetails?.user.userName ?? ""
        vc.imageUsers = "http://34.231.88.85/Human/humanresource_node_backend/assets/images/\(jobDetails?.user.image ?? "")"
        socket.connect()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onJobApplyTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobApplyVC") as! JobApplyVC
        vc.jobId = self.jobId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onShowDocumentTap(_ sender: Any) {
        let url = "http://34.231.88.85/Human/humanresource_node_backend/assets/files/\(jobDetails?.contructionDocumentation ?? "")"
        UIApplication.shared.open(URL(string: url)!)
    }
    @IBAction func onCompanyDescription(_ sender: Any) {
        jobDescriptionView.isHidden = true
        mainview.addSubview(companyDescription)
    }
}

extension JobDescriptionVC{
    func getApiData(){
        ARSLineProgress.show()
        ApiManager.shared.jobDetailById(id: jobId) { [self] jobDetail, isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                jobDetails = jobDetail
                setData()
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
    }
    func setData(){
        experienceRequired.text = jobDetails?.planOfAction
        jobName.text = jobDetails?.title
        jobLocation.text = "\(jobDetails?.location ?? ""), \(jobDetails?.country ?? "")"
        jobType.text = jobDetails?.jobType
        salary.text = "$ \(jobDetails?.priceTo ?? 100)"
        skillsRequired.text = jobDetails?.scopeOfWork
        companyLocation.text = jobDetails?.location
        companyAddress.text = jobDetails?.company.address
        companyContact.text = jobDetails?.company.phoneNumber
        emailCompany.text = jobDetails?.company.email
        planOfAction.text = jobDetails?.planOfAction
    }
}
