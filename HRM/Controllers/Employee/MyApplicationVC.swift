//
//  MyApplicationVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyApplicationVC: UIViewController {

    @IBOutlet weak var applicationTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onEditTap(_ sender: UIButton){
        
    }
    @IBAction func onStatusTap(_ sender: UIButton){
        
    }
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MyApplicationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicationTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyApplicationTableCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
