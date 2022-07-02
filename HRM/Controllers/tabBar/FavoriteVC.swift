//
//  FavoriteVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var favoriteTable:UITableView!
    var favoriteListdata = [GetWishlistModel?]()
    override func viewDidLoad() {
        super.viewDidLoad()

        favouriteListApi()
    }
    

}

extension FavoriteVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteListdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        cell.name.text = favoriteListdata[indexPath.item]?.job?.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDescriptionVC") as! JobDescriptionVC
        vc.jobId = favoriteListdata[indexPath.row]?.job?.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension FavoriteVC{
    func favouriteListApi(){
        let userId = UserDefaults.standard.value(forKey: "userId") as! String
        ApiManager.shared.getWishlistApi(userid: userId) { respon, isSuccess in
            if isSuccess{
                self.favoriteListdata = respon
                self.favoriteTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
}
