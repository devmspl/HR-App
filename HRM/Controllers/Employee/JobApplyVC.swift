//
//  JobApplyVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit
import ARSLineProgress
import UniformTypeIdentifiers

class JobApplyVC: UIViewController, UIDocumentPickerDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var discription: UITextView!
    @IBOutlet weak var cvResume: UIButton!
    @IBOutlet weak var countryPick: UIButton!
    
    var picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text,.image],asCopy: true)
//    var picker1 = UIDocumentPickerViewController(forExporting: <#T##[URL]#>)
    var userId = ""
    var jobId = ""
    var urlPdf = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
    }
        
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else{return}
        self.urlPdf = "\(url)"
        print(url,"newUrl")
    
    }
    @IBAction func onBackTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onDocumentUploadTap(_ sender:UIButton){
        self.present(picker, animated: true)
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
//                    ApiManager.shared.uploadd
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
    }
}
