//
//  LandingScreenVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit

class LandingScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onStartTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
