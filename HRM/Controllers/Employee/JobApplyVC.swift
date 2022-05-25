//
//  JobApplyVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit

class JobApplyVC: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var discription: UITextView!
    @IBOutlet weak var cvResume: UIButton!
    @IBOutlet weak var countryPick: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBackTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onApplynowTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
