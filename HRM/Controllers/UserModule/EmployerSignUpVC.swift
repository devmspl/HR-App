//
//  EmployerSignUpVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class EmployerSignUpVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        password.isSecureTextEntry = true
   
    }
    
   
   
    @IBAction func onGoogleTap(_ sender: Any) {
    }
  
    @IBAction func showPassword(_ sender: Any) {
        if password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    @IBAction func onAppleTap(_ sender: Any) {
    }
    @IBAction func createAccount(_ sender: Any) {
        let model = signUpModel(userName: userName.text!, email: email.text!, companyName: companyName.text!, password: password.text!, roleType: "employer", phoneNumber: "532343534543")
        ApiManager.shared.signUpApi(model: model) { response, isSuccess in
            if isSuccess{
                self.showAlertWithOneAction(alertTitle: "Human resource", message: "Account created successfully please login", action1Title: "Ok") { ok in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        
       
        }
    }
    @IBAction func loginTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
