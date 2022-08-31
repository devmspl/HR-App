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
        view.overrideUserInterfaceStyle = .light
        
    }
    
    @IBAction func onEmployeeTap(_ sender: Any) {
        UserDefaults.standard.setValue("employee", forKey: "type")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onEmployerTap(_ sender: Any) {
        UserDefaults.standard.setValue("employer", forKey: "type")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
