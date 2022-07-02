//
//  WelcomeVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func onEmployeeTap(_ sender: Any) {
        UserDefaults.standard.setValue("Employee", forKey: "type")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onEmployerTap(_ sender: Any) {
        UserDefaults.standard.setValue("Employer", forKey: "type")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
