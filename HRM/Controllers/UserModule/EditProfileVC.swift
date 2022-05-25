//
//  EditProfileVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onBackTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onSaveTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
