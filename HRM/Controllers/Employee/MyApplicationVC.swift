//
//  MyApplicationVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 24/05/22.
//

import UIKit

class MyApplicationVC: UIViewController,UIDocumentPickerDelegate {

    @IBOutlet weak var applicationTable: UITableView!
    
    var myApplication = [ApplyListByIdModel?]()
    var picker = UIDocumentPickerViewController.init(documentTypes: [".pdf", ".png", ".jpeg", ".jpg"], in: .open)

    override func viewDidLoad() {
        super.viewDidLoad()
        getApplications()
        view.overrideUserInterfaceStyle = .light
        picker.delegate = self
    }
    
    @IBAction func onEditTap(_ sender: UIButton){
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func onStatusTap(_ sender: UIButton){
        
    }
    @IBAction func onBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension MyApplicationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myApplication.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicationTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyApplicationTableCell
        cell.companyName.text = myApplication[indexPath.row]!.firstName
        cell.jobName.text = myApplication[indexPath.row]!.job.jobType
        cell.address.text = myApplication[indexPath.row]!.country
        cell.date.text = myApplication[indexPath.row]!.email
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension MyApplicationVC{
    func getApplications(){
        let userId = UserDefaults.standard.object(forKey: "userId") as! String
        ApiManager.shared.applyListByUserId(id: userId) { response, isSuccess in
            if isSuccess{
                self.myApplication = response
                self.applicationTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
