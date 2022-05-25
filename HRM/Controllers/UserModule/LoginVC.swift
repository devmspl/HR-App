//
//  LoginVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func onLoginWithGoogleTap(_ sender: Any) {
    }
    @IBAction func onAppleLogin(_ sender: Any) {
    }
    @IBAction func onLoginTap(_ sender: Any) {
        let loginModel = loginModel(email: email.text!, password: password.text!)
        ApiManager.shared.loginApi(model: loginModel) { response,isSuccess in
            if isSuccess{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    @IBAction func onForgotPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onCreateAccount(_ sender: Any) {
        if UserDefaults.standard.value(forKey: "type") as! String == "Employee"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeSignUpVC") as! EmployeeSignUpVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmployerSignUpVC") as! EmployerSignUpVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
    @IBAction func onShowPassword(_ sender: Any) {
    }
}
