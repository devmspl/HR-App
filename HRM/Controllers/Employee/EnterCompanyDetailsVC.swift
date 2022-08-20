//
//  CompanyDetails.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import DropDown

class EnterCompanyDetailsVC: UIViewController {

 //MARK: -
    @IBOutlet weak var skillRequired: UITextView!
    @IBOutlet weak var experienceRequiredText: UITextField!
    @IBOutlet weak var addresstext: UITextView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet var roundViews: [UIView]!
//MARK: - VARIABLES
    var jobTitle = ""
    var jobCategory = ""
    var ownership = ""
    var city = ""
    var priceFrom = ""
    var priceTo = ""
    var workers = ""
    var jobType = ""
    var firstName = ""
    var lastName = ""
    var yourEmail = ""
    var country = ""
    var scopeOfWork = ""
    var plansOfAction = ""
    var constructionDoc = ""
    
    var drop = DropDown()
//MARK: - VIEWDID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...roundViews.count-1{
            roundViews[i].layer.cornerRadius = 10
        }
        
    }
//MARK: - ACTIONS
    @IBAction func postTapped(_ sender: Any) {
        if addresstext.text == "" || companyName.text == "" || phone.text == ""{
            self.alert(message: "Please enter company details")
        }else{
            createJob()
        }
    }
    @IBAction func experienceTap(_ sender: Any) {
        drop.anchorView = experienceRequiredText
        drop.dataSource = ["0-1 year","1-3 years","3-5 years","5-8 years"]
        drop.selectionAction = { [unowned self] (index: Int,item: String) in
            
            experienceRequiredText.text = item
        }
    }
    @IBAction func jobDescriptionTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension EnterCompanyDetailsVC{
    func createJob(){
        let userId = UserDefaults.standard.object(forKey: "userId") as! String
        let compaydata = CompanyDat(address: addresstext.text, emailId: companyName.text!, experience: experienceRequiredText.text, phoneNumber: phone.text, skills: skillRequired.text)
        let model = CreateJobModel(title: jobTitle, categoryId: jobCategory, userId: userId, location: city, priceFrom: Int(priceFrom), priceTo: Int(priceTo), workers: Int(workers), jobType: jobType, firstName: firstName, lastName: lastName, email: yourEmail, country: country, scopeOfWork: scopeOfWork, planOfAction: plansOfAction, contructionDocumentation: constructionDoc, company: compaydata)
        print(model,"sdvasv")
        ApiManager.shared.createJob(model: model) { isSuccess in
            if isSuccess{
                self.view.makeToast("Job Successfully created")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployerHomeVC") as! EmployerHomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}

