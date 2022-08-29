//
//  JobApplyVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit
import ARSLineProgress
import ADCountryPicker
import UniformTypeIdentifiers

class JobApplyVC: UIViewController, UIDocumentPickerDelegate,ADCountryPickerDelegate {
    
    @IBOutlet weak var countryname: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var docname: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var discription: UITextView!
    @IBOutlet weak var cvResume: UIButton!
    @IBOutlet weak var countryPick: UIButton!
    
    var picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text,.image],asCopy: true)
    let countryPicker = ADCountryPicker()
    var userId = ""
    var jobId = ""
    var urlPdf = ""
    var fileName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
    }
//MARK: -Picker methods
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else{return}
        self.urlPdf = "\(url)"
        self.fileName = url.lastPathComponent
        docname.text = self.fileName
        print(url,"newUrl")
    }
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        print(name,code,dialCode,"sdfghj")
    }
//MARK: - button actions
    @IBAction func onBackTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onDocumentUploadTap(_ sender:UIButton){
        self.present(picker, animated: true)
        
    }
    @IBAction func countryPicker(_ sender:UIButton){
        self.present(countryPicker, animated: true, completion: nil)
        countryPicker.didSelectCountryClosure = { name, code in
            let flagImage =  self.countryPicker.getFlag(countryCode: code)
            self.countryImage.image = flagImage
            self.countryname.text = name
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func onApplynowTap(_ sender:UIButton){
        if self.urlPdf == ""{
            self.alert(message: "Please upload resume")
        }else{
            applyJob()
        }
        
    }

}

extension JobApplyVC{
    func applyJob(){
        ARSLineProgress.show()
        let model = JobApplyModel(userId: self.userId ?? "", jobId: self.jobId ?? "", firstName: firstName.text!, lastname: lastName.text!, email: email.text!, country: countryname.text!, describe: discription.text!, resume: "string", status: "in-process")
        print(model,"asdvsad")
        ApiManager.shared.jobApplyApi(model: model) { [self] isSuccess,id in
            ARSLineProgress.hide()
            if isSuccess{
                ApiManager.shared.uploadfile(apiURL: ApiUrls.applyJobDoc+id, dataObj:URL(string: self.urlPdf)! , strfilename: self.fileName) { percent in
                    print("successFully Uploaded")
                } completion: { result, error in
                    print("sadsdf",result,error,"cvvdfvsf")
                }
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
