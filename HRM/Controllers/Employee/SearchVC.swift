//
//  SearchVC.swift
//  HRM
//
//  Created by MacBook M1 on 02/08/22.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchJobTable: UITableView!
    var searchData = [JobData]()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    @IBAction func onFilterTap(_ sender: Any) {
    }
    
    @IBAction func onLikeTap(_ sender: Any) {
    }
    @IBAction func onSearchTap(_ sender: Any) {
        searchDataApi()
    }
    
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchJobTable.dequeueReusableCell(withIdentifier: "cell") as! SearchTableCell
        cell.likeBtn.tag = indexPath.row
        cell.jobName.text = searchData[indexPath.row].title
        cell.jobHour.text = searchData[indexPath.row].jobType
        cell.jobLocation.text = "\(searchData[indexPath.row].priceTo ?? 0)/m \(searchData[indexPath.row].country ?? "")"
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC") as! JobDescriptionVC
        vc.jobId = self.searchData[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchVC{
    func searchDataApi(){
        ApiManager.shared.jobSearchApi(text: searchTextField.text!) { data, isSuccess in
            if isSuccess{
                self.searchData = data
                self.searchJobTable.reloadData()
            }
            else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
