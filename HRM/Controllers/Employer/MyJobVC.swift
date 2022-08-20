//
//  InterviewStatusVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyJobVC: UIViewController {

    @IBOutlet weak var jobTable: UITableView!
    
    var jobData = [JobAndCompanyDetailModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyJobs()
    }
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onDeleteJobTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyJobVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jobTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyJobTableCell
        cell.selectionStyle = .none
        cell.jobName.text = jobData[indexPath.row].title
        cell.salaryAndLocation.text = "\(jobData[indexPath.row].priceTo ?? 0)/m \(jobData[indexPath.row].location ?? ""),\(jobData[indexPath.row].country ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyApplicantsVC") as! MyApplicantsVC
        vc.jobId = jobData[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyJobVC{
    func getMyJobs(){
        let userId = UserDefaults.standard.object(forKey: "userId") as! String
        ApiManager.shared.getJobByUserId(userId: userId) { data, isSuccess in
            if isSuccess{
                self.jobData = data
                self.jobTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
