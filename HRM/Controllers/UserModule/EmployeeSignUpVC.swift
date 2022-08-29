//
//  SignUpVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class EmployeeSignUpVC: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginWithGoogleTap(_ sender: Any) {
    }
    @IBAction func onAppleLogin(_ sender: Any) {
    }
    @IBAction func onLoginTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func onCreateAccount(_ sender: Any) {
        let model = signUpModel(userName: userName.text!, email: email.text, companyName: "", password: password.text!, roleType: "employee", phoneNumber: "23423")
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
    @IBAction func onShowPassword(_ sender: Any) {
        if password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }

}
