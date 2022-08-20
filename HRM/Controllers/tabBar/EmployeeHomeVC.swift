//
//  EmployeeHomeVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import ARSLineProgress

class EmployeeHomeVC: UIViewController {

    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var homeTable: UITableView!
  
    var popularJobsArray = [JobDetailModel]()
    var recentJobsArray = [JobDetailModel]()

    var userId = ""
    var like = false
    var jobId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
            getPopularJob()
        userId = UserDefaults.standard.value(forKey: "userId") as! String
        like = false
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

  //MARK: - IB ACTIONS
    @IBAction func oncollectionLikeTap(_ sender: UIButton){
        
        jobId = popularJobsArray[sender.tag].id!
        let model = CreateWishlistModel(userId: self.userId, jobId: jobId, status: true)
        ApiManager.shared.createWishlist(model: model) { isSuccess in
            if isSuccess{
                if self.like == true{
                    self.like = false
                }else{
                    self.like = true
                }
                self.homeCollection.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    @IBAction func ontableLikeTap(_ sender: UIButton){
        like = true
        jobId = recentJobsArray[sender.tag].id!
        let model = CreateWishlistModel(userId: self.userId, jobId: jobId, status: true)
        ApiManager.shared.createWishlist(model: model) { isSuccess in
            if isSuccess{
                if self.like == true{
                    self.like = false
                }else{
                    self.like = true
                }
                self.homeTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    @IBAction func searchTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC")  as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func collectionShowAllTap(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowAllVC")  as! ShowAllVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func tableShowAllTap(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowAllVC")  as! ShowAllVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onClickProfile(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC")  as! ProfileVC
        vc.key = "Employee"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
extension EmployeeHomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentJobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableCell
        cell.selectionStyle = .none
        cell.likeBtn.tag = indexPath.row
        if like == true{
            cell.likeBtn.setImage(UIImage(named:"likeActive"), for: .normal)
        }else{
            cell.likeBtn.setImage(UIImage(named:"likeInactive"), for: .normal)
        }
        cell.jobName.text = recentJobsArray[indexPath.row].jobName
        cell.salary.text = "$ \(recentJobsArray[indexPath.row].salary ?? 0)"
        cell.jobType.text = recentJobsArray[indexPath.row].imageUrl
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC")  as! JobDescriptionVC
         let id = recentJobsArray[indexPath.row].id as! String
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
        cell.likeBtn.tag = indexPath.item
        if like == true{
            cell.likeBtn.setImage(UIImage(named:"likeActive"), for: .normal)
        }else{
            cell.likeBtn.setImage(UIImage(named:"likeInactive"), for: .normal)
        }
        cell.jobName.text = popularJobsArray[indexPath.row].jobName
        cell.salaryAndLocation.text = "$ \(popularJobsArray[indexPath.row].salary ?? 0), \(popularJobsArray[indexPath.row].location ?? "")"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeCollection.frame.width/1.2, height: homeCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC")  as! JobDescriptionVC
         let id = popularJobsArray[indexPath.row].id  as! String
        vc.jobId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



