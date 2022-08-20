//
//  MyApplicantsVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyApplicantsVC: UIViewController {

//MARK: - OUTLETS
    @IBOutlet weak var applicantTable: UITableView!
//MARK: - VARIABLES
    var jobId = ""
    var applicantsData = [ApplicantsDataModel]()
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        jobApplicants()

    }
//MARK: - ACTION
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK: - EXTENSION

extension MyApplicantsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applicantsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicantTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyApplicantsTableCell
        cell.selectionStyle = .none
        cell.applicatntName.text = "\(applicantsData[indexPath.row].firstName ?? "") \(applicantsData[indexPath.row].lastName ?? "")"
        cell.applicantsNumber.text = applicantsData[indexPath.row].applyBy?.phoneNumber ?? ""
        cell.apllicationDate.text = applicantsData[indexPath.row].date ?? ""
//        let dateformatter = DateFormatter()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ApplicantsDetailVC") as! ApplicantsDetailVC
        vc.applyId = applicantsData[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyApplicantsVC{
    func jobApplicants(){
        ApiManager.shared.getJobApplications(jobId: self.jobId) { data, isSucess in
            if isSucess{
                self.applicantsData = data
                self.applicantTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
