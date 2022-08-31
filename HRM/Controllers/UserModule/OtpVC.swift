//
//  OtpVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class OtpVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text4.delegate = self
        view.overrideUserInterfaceStyle = .light
    }
    
   
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendTapped(_ sender: Any) {
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == text1{
            text1.text = ""
        }else if textField == text2{
            text2.text = ""
        }else if textField == text3{
            text3.text = ""
        }else{
            text4.text = ""
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == text1{
            if text1.text!.count > 0{
//                text1.resignFirstResponder()
                text2.becomeFirstResponder()
            }else{
                text1.becomeFirstResponder()
            }
        }else if textField == text2{
            if text2.text!.count > 0{
//                text2.resignFirstResponder()
                text3.becomeFirstResponder()
            }else{
                text2.becomeFirstResponder()
            }
        }else if textField == text3{
            if text3.text!.count > 0{
//                text3.resignFirstResponder()
                text4.becomeFirstResponder()
            }else{
                text3.becomeFirstResponder()
            }
        }else {
            if text4.text!.count > 0{
                text4.resignFirstResponder()
                text1.resignFirstResponder()
                text2.resignFirstResponder()
                text3.resignFirstResponder()
            }else{
                text4.becomeFirstResponder()
            }
        }
        return true
    }
    @IBAction func nextTapped(_ sender: Any) {
        
        let model = otpModel(otp: "\(text1.text!)"+"\(text2.text!)"+"\(text3.text!)"+"\(text4.text!)")
        ApiManager.shared.otpApi(model: model) { [self] response, isSuccess in
            if isSuccess{
                let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                alert(message: ApiManager.shared.message)
            }
            }
        }
       

}
