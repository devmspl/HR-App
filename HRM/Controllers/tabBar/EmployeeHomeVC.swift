//
//  EmployeeHomeVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit

class EmployeeHomeVC: UIViewController {

    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC")  as! JobDescriptionVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension EmployeeHomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeCollection.frame.width/1.2, height: homeCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC")  as! JobDescriptionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

