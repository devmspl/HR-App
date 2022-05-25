//
//  OtpVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class OtpVC: UIViewController {

    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
   
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendTapped(_ sender: Any) {
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
