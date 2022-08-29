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
        
    }

    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onChangePaswordTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
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
