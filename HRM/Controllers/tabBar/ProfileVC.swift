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
    var employerOption = ["Edit Profile","Change Password","My Applicants","Credits Earned","Country and Language","Sign out"]
    var profileData = GetProfileModel()
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
       
    }
    

}

extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserDefaults.standard.value(forKey: "type") as! String == "Employee"{
            return optionArray.count
        }else{
            return employerOption.count
        }
       
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
            if UserDefaults.standard.value(forKey: "type") as! String == "Employee"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyApplicationVC") as! MyApplicationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyApplicantsVC") as! MyApplicantsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            print("hello")
        }
    }
    
}


extension ProfileVC{
    func getProfile(){
        let userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
        ApiManager.shared.getProfile(userId: userId) {[self] profile,isSuccess in
            if isSuccess{
                
                profileData = profile!
                setData()
                print("hello")
            }else{
                alert(message: ApiManager.shared.message)
            }
        }
        
}
    
    func setData(){
        name.text = profileData.name
        email.text = profileData.email
        role.text = profileData.type
        contactNo.text = profileData.number
        
    }
}


