//
//  EmployerHomeVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import DropDown
import Toast_Swift
class EmployerHomeVC: UIViewController {
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var jobtype: UITextField!
    @IBOutlet weak var ownerShip: UITextField!
    @IBOutlet weak var jobCategory: UITextField!
    @IBOutlet weak var jobtitle: UITextField!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var priceTo: UITextField!
    @IBOutlet weak var priceFrom: UITextField!
    @IBOutlet weak var workerbtn: UIButton!
    @IBOutlet var roundViews: [UIView]!
    @IBOutlet weak var workerCount: UILabel!
    
    let drop = DropDown()
    var categoryArray = [GetCategoryModel]()
    var cateArray = [String]()
    var categoryId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeHolders()
        for i in 0...roundViews.count-1{
            roundViews[i].layer.cornerRadius = 20
        }
        getcategory()
    }
    func placeHolders(){
        jobtitle.attributedPlaceholder = NSAttributedString(string: "Job title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        ownerShip.attributedPlaceholder = NSAttributedString(string: "Ownership", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        locationText.attributedPlaceholder = NSAttributedString(string: "City", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        priceFrom.attributedPlaceholder = NSAttributedString(string: "$0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        priceTo.attributedPlaceholder = NSAttributedString(string: "$0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    @IBAction func numberOfWorkers(_ sender: Any) {
        drop.dataSource = ["1","2","3","4","5","6","7","8","9","10"]
        drop.anchorView = workerbtn
        drop.show()
        drop.selectionAction = { [unowned self] (index: Int, item: String) in
            workerCount.text = item
            drop.hide()
            
        }
    }
    @IBAction func selectCategory(_ sender: Any) {
        drop.dataSource = cateArray
        drop.anchorView = jobCategory
        drop.show()
        drop.selectionAction = { [unowned self] (index: Int,Item: String) in
            self.categoryId = categoryArray[index].categoryId ?? ""
            self.jobCategory.text = categoryArray[index].category ?? ""
        }
    }
    
    @IBAction func selectJobtype(_ sender: Any) {
        drop.dataSource = ["Full Time","Part Time","Contrat","Remote","Freelancer"]
        drop.anchorView = jobtype
        drop.show()
        drop.selectionAction = { [unowned self] (index: Int, item: String) in
            jobtype.text = item
            drop.hide()
            
        }
    }
    
    @IBAction func profileTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        vc.key = "Employer"
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    @IBAction func jobDescriptionTapped(_ sender: Any) {
        if jobtitle.text == "" || jobCategory.text == "" || ownerShip.text == "" || locationText.text == "" || priceFrom.text == "" || priceTo.text == "" || workerCount.text == "" || jobtype.text == ""{
            self.view.makeToast("Please enter job details first")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EnterJobDescriptionVC") as!  EnterJobDescriptionVC
            vc.jobTitle = jobtitle.text ?? ""
            vc.jobCategory = self.categoryId
            vc.ownership = ownerShip.text ?? ""
            vc.city = locationText.text ?? ""
            vc.priceFrom = priceFrom.text ?? ""
            vc.priceTo = priceTo.text ?? ""
            vc.workers = workerCount.text ?? ""
            vc.jobType = jobtype.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
   
    }
    
    @IBAction func companyDetailTapped(_ sender: Any) {
        if jobtitle.text == "" || jobCategory.text == "" || ownerShip.text == "" || locationText.text == "" || priceFrom.text == "" || priceTo.text == "" || workerCount.text == "" || jobtype.text == ""{
            self.view.makeToast("Please enter job details first")
        }else{
            self.view.makeToast("Please enter job description first")
        }
       
     
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EnterCompanyDetailsVC") as!  EnterCompanyDetailsVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension EmployerHomeVC{
    func getcategory(){
        ApiManager.shared.getAllCategories {[self] data, issuccess in
            if issuccess{
                self.categoryArray = data
                for i in 0...categoryArray.count-1{
                    self.cateArray.append(categoryArray[i].category ?? "")
                }
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
