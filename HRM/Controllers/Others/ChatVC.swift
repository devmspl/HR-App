//
//  ChatVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit

class ChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onBacktap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
