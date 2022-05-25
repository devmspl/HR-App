//
//  ProfileVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit

class ProfileVC: UIViewController {
    ///
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var role:UILabel!
    @IBOutlet weak var contactNo:UILabel!
    @IBOutlet weak var email:UILabel!
    @IBOutlet weak var profileTable:UITableView!{
        didSet{
            profileTable.tableHeaderView = UIView(frame: .zero)
        }
    }
    
    ///
    var optionArray = ["Edit Profile","Change Password","My Applications","Credits Earned","Country and Language","Sign out"]
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

}

extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableCell
        cell.tableLabel.text = optionArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyApplicationVC") as! MyApplicationVC
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("hello")
        }
    }
    
}
