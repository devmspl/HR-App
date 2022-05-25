//
//  InterviewStatusVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class InterviewStatusVC: UIViewController {

    @IBOutlet weak var interviewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onCheckCVTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onEndInterviewTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension InterviewStatusVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = interviewTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InterviewTableCell
        cell.selectionStyle = .none
        return cell
    }
    
}
