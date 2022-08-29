//
//  TabBarVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import UIKit

class TabBarVC: UITabBarController {

    
    var btn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHome()
        self.tabBar.items![1].isEnabled = false
//        setupMiddleButton()
    }

    func setUpHome(){
        setupMiddleButton()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EmployeeHomeVC") as! EmployeeHomeVC
        let vc1 = storyboard.instantiateViewController(withIdentifier: "EmployerHomeVC") as! EmployerHomeVC
        
        if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
            self.viewControllers?[0] = vc
//         
        }else{
            self.viewControllers?[0] = vc1
            self.tabBar.items?[0].image = UIImage(named: "ic_home_inactive")?.withRenderingMode(.alwaysOriginal)
            self.tabBar.items?[0].selectedImage = UIImage(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    func setupMiddleButton() {
  
         let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
            btn = middleBtn
         
        btn.setImage(UIImage(named: "ic_chat_active"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = UIColor(named: "buttonColor")
        
            //add to the tabbar and add click event
        
            self.tabBar.addSubview(middleBtn)
       
        btn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
        
        }

        // Menu Button Touch Action
        @objc func menuButtonAction(sender: UIButton) {
            self.selectedIndex = 1
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
            self.viewControllers?[1] = vc
        }
    
}
