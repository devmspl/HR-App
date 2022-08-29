//
//  FavoriteVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import UIKit
import ARSLineProgress

class FavoriteVC: UIViewController {

    @IBOutlet weak var favoriteTable:UITableView!
    var favoriteListdata = [GetWishlistModel?]()
    var wishlistId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        favouriteListApi()
    }
    
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func removeFromWishList(_ sender: UIButton) {
        removeFromFavorite()
    }
}

extension FavoriteVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteListdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        cell.removeBtn.tag = indexPath.row
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
        ApiManager.shared.getWishlistApi(userid: userId) { [self] respon, isSuccess in
            if isSuccess{
                self.favoriteListdata = respon
                if  self.favoriteListdata.count != 0{
                    for i in 0...self.favoriteListdata.count-1{
                        self.wishlistId = favoriteListdata[i]?.id ?? ""
                    }
                    self.favoriteTable.reloadData()
                }
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    func removeFromFavorite(){
        ARSLineProgress.show()
        ApiManager.shared.deleteWishlist(wishlistId: self.wishlistId) {[self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                favouriteListApi()
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
    }
}
