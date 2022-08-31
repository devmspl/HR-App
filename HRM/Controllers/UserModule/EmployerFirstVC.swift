//
//  EmployerFirstVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class EmployerFirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
    }
    

    @IBAction func postJobTap(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
