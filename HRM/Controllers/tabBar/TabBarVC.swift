//
//  TabBarVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHome()
    }

    func setUpHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EmployeeHomeVC") as! EmployeeHomeVC
        let vc1 = storyboard.instantiateViewController(withIdentifier: "EmployerHomeVC") as! EmployerHomeVC
        
        if UserDefaults.standard.value(forKey: "type") as! String == "Employee"{
            self.viewControllers?[0] = vc
//         
        }else{
            self.viewControllers?[0] = vc1
            self.tabBar.items?[0].image = UIImage(named: "ic_home_inactive")?.withRenderingMode(.alwaysOriginal)
            self.tabBar.items?[0].selectedImage = UIImage(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
}
