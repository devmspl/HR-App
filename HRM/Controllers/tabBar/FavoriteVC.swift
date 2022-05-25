//
//  FavoriteVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var favoriteTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

}

extension FavoriteVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
