//
//  EmployeeHomeVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import GeometricLoaders
import ARSLineProgress

class EmployeeHomeVC: UIViewController {

    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var searchText: UITextField!
  
    var container: WaterWaves?
    var popularJobsArray = [JobDetailModel]()
    var recentJobsArray = [JobDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            getPopularJob()
        
    }
  
    
    func getPopularJob(){
        ARSLineProgress.show()
        ApiManager.shared.popularJobs { [self]  response, isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                popularJobsArray.append(contentsOf: response)
                homeCollection.reloadData()
                getRecentJob()
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
    }
    func getRecentJob(){
        ARSLineProgress.show()
        ApiManager.shared.recentJobs {[self]  response, isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                recentJobsArray.append(contentsOf: response)
                homeTable.reloadData()
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
    }

    
    @IBAction func onFilterTap(_ sender: UIButton){
        
    }
    @IBAction func oncollectionLikeTap(_ sender: UIButton){
        
    }
    @IBAction func ontableLikeTap(_ sender: UIButton){
        
    }
    @IBAction func collectionShowAllTap(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC")  as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func tableShowAllTap(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC")  as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onClickProfile(_ sender: UIButton){
        
    }
    

}
extension EmployeeHomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularJobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableCell
        cell.selectionStyle = .none
        cell.jobName.text = popularJobsArray[indexPath.row].jobName
        cell.salary.text = "$ \(popularJobsArray[indexPath.row].salary ?? 0)"
        cell.jobType.text = popularJobsArray[indexPath.row].imageUrl
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC")  as! JobDescriptionVC
        guard let id = recentJobsArray[indexPath.row].id else {return}
        vc.jobId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension EmployeeHomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return popularJobsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionCell
        cell.jobName.text = popularJobsArray[indexPath.row].jobName
        cell.salaryAndLocation.text = "$ \(popularJobsArray[indexPath.row].salary ?? 0), \(popularJobsArray[indexPath.row].location ?? "")"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeCollection.frame.width/1.2, height: homeCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC")  as! JobDescriptionVC
        guard let id = popularJobsArray[indexPath.row].id else {return}
        vc.jobId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

