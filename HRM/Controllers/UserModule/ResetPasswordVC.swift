//
//  ResetPasswordVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class ResetPasswordVC: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        let model = resetPasswordModel(newPassword: password.text!)
        ApiManager.shared.resetPasswordApi(model: model) { response, isSuccess in
            if isSuccess{
                self.showAlertWithOneAction(alertTitle: "Human resource", message: ApiManager.shared.message, action1Title: "Ok") { ok in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoneVC") as! DoneVC
                    self.navigationController?.pushViewController(vc, animated: true)                }
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
       
    }
    @IBAction func showPassword(_ sender: Any) {
    }
    @IBAction func show(_ sender: Any) {
    }

}
