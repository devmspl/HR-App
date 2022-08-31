//
//  ChangePasswordVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
    }

    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onChangePaswordTap(_ sender: UIButton){
        if oldPassword.text == ""{
            self.alert(message: "Please enter oldPassword")
        }else if newPassword.text == ""{
            self.alert(message: "Please enter newPassword")
        }else if newPassword.text != confirmPassword.text{
            self.alert(message: "Password mismatch")
        }else{
            changepassApi()
        }
        
    }
    @IBAction func onshowOldPaswordTap(_ sender: UIButton){
        if oldPassword.isSecureTextEntry == true{
            oldPassword.isSecureTextEntry = false
            }else{
                oldPassword.isSecureTextEntry = true
            }
    }
    @IBAction func onShownewPaswordTap(_ sender: UIButton){
        if newPassword.isSecureTextEntry == true{
            newPassword.isSecureTextEntry = false
            }else{
                newPassword.isSecureTextEntry = true
            }    }
    @IBAction func onShowConPaswordTap(_ sender: UIButton){
        if confirmPassword.isSecureTextEntry == true{
            confirmPassword.isSecureTextEntry = false
            }else{
                confirmPassword.isSecureTextEntry = true
            }
    }
}

extension ChangePasswordVC{
    func changepassApi(){
        let userId = UserDefaults.standard.value(forKey: "userId") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        ApiManager.shared.changePassword(userid: userId, token: token, newPassword: newPassword.text!, oldPassword: oldPassword.text!) { result, isSuccess in
            if isSuccess{
              
                self.showAlertWithOneAction(alertTitle: "Password Changed", message: "Password Successfully Changed", action1Title: "Ok") { ok in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
