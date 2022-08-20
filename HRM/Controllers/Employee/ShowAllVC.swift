//
//  SearchVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class ShowAllVC: UIViewController {

    @IBOutlet weak var mostRecentBtn: UIButton!
    @IBOutlet weak var mostRelevantBtn: UIButton!
    @IBOutlet weak var searchTable: UITableView!
    
    var showAllData = [JobAndCompanyDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allJobs()
    }
    
    @IBAction func onMostRelevanttap(_ sender: Any) {
    }
    @IBAction func onMostRecentTap(_ sender: Any) {
    }
    @IBAction func onLikeTap(_ sender: Any) {
    }
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
}
extension ShowAllVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showAllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableCell
        cell.selectionStyle = .none
        cell.jobName.text = showAllData[indexPath.row].title
        cell.jobHour.text = showAllData[indexPath.row].jobType
        cell.jobLocation.text = "\(showAllData[indexPath.row].priceTo ?? 0)/m \(showAllData[indexPath.row].location ?? "") \(showAllData[indexPath.row].country ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC") as! JobDescriptionVC
        vc.jobId = self.showAllData[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ShowAllVC{
    func allJobs(){
        ApiManager.shared.getAllJobs { [self] data, isSuccess in
            if isSuccess{
                self.showAllData = data
                searchTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
