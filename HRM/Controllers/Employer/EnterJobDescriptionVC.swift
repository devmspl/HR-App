//
//  EnterJobDescriptionVC.swift
//  HRM
//
//  Created by MacBook M1 on 04/07/22.
//

import UIKit
import ADCountryPicker
import Toast_Swift

class EnterJobDescriptionVC: UIViewController,ADCountryPickerDelegate{
    
    
    
    @IBOutlet weak var docname: UILabel!
    @IBOutlet weak var planOfAction: UITextField!
    @IBOutlet weak var scopeOfWork: UITextField!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet var roundViews: [UIView]!
    let picker = ADCountryPicker()
    
    //MARK: - data from back screen
    ///
    var jobTitle = ""
    var jobCategory = ""
    var ownership = ""
    var city = ""
    var priceFrom = ""
    var priceTo = ""
    var workers = ""
    var jobType = ""
    ///
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...roundViews.count-1{
            roundViews[i].layer.cornerRadius = 10
        }
    }
    
    
    //MARK: - buttonActions
    @IBAction func uploadDocTapped(_ sender: Any) {
    }
    @IBAction func selectCountry(_ sender: Any) {
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
        picker.didSelectCountryClosure = { name, code in
            let flagImage =  self.picker.getFlag(countryCode: code)
            self.countryFlag.image = flagImage
            self.country.text = name
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func jobDetailsTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func companyDescription(_ sender: Any) {
        
        if firstName.text == "" || lastName.text == "" || email.text == "" || country.text == "" || planOfAction.text == "" || scopeOfWork.text == ""{
            self.view.makeToast("Please enter all job description details")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EnterCompanyDetailsVC") as! EnterCompanyDetailsVC
            vc.jobTitle = jobTitle
            vc.jobCategory = jobCategory
            vc.ownership = ownership
            vc.city = city
            vc.priceFrom = priceFrom
            vc.priceTo = priceTo
            vc.workers = workers
            vc.jobType = jobType
            vc.firstName = firstName.text ?? ""
            vc.lastName = lastName.text ?? ""
            vc.yourEmail = email.text ?? ""
            vc.country = country.text ?? ""
            vc.plansOfAction = planOfAction.text ?? ""
            vc.scopeOfWork = scopeOfWork.text ?? ""
            vc.constructionDoc = ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    //////////////////
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        print(dialCode)
    }
    ////////////////////////
    
    
}
