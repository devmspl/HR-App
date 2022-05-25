//
//  ForgetPasswordVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class ForgetPasswordVC: UIViewController {
   
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitTapped(_ sender: Any) {
        let model = forgetPassword(email: email.text!)
        ApiManager.shared.forgetPasswordApi(model: model) {[self] response, isSuccess in
            if isSuccess{
                let vc = storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                navigationController?.pushViewController(vc, animated: true)
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
        
    }
   
}
