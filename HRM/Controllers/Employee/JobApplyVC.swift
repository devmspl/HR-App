//
//  JobApplyVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit
import ARSLineProgress

class JobApplyVC: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var discription: UITextView!
    @IBOutlet weak var cvResume: UIButton!
    @IBOutlet weak var countryPick: UIButton!
    
    var userId = ""
    var jobId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
    }
    
    
    @IBAction func onBackTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onApplynowTap(_ sender:UIButton){
        applyJob()
    }

}

extension JobApplyVC{
    func applyJob(){
        ARSLineProgress.show()
        let model = JobApplyModel(userId: self.userId ?? "", jobId: self.jobId ?? "", firstName: firstName.text!, lastname: lastName.text!, email: email.text!, country: "USA", describe: discription.text!, resume: "string", status: "in-process")
        print(model,"asdvsad")
        ApiManager.shared.jobApplyApi(model: model) { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                self.showAlertWithOneAction(alertTitle: "", message: "Job applied Successfully", action1Title: "Ok") { ok in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
    }
}
