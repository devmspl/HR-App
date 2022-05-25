//
//  MyApplicantsVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyApplicantsVC: UIViewController {

    
    @IBOutlet weak var applicantTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MyApplicantsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicantTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyApplicantsTableCell
        cell.selectionStyle = .none
        return cell
    }
    
}
