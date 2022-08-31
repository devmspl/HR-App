//
//  ProfileVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import AlamofireImage

class ProfileVC: UIViewController {
    ///
    @IBOutlet weak var backBtn: UIButton!
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
    
    var key = ""
    ///
    var userid = ""
    var token = ""
    var optionArray = ["Edit Profile","Change Password","My Applications","My Wishlist","Sign out","Delete Account"]
    var employerOption = ["Edit Profile","Change Password","My Jobs","Sign out","Delete Account"]
    var profileData = GetProfileModel()
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.overrideUserInterfaceStyle = .light
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
        if key == ""{
            backBtn.isHidden = true
        }else{
            backBtn.isHidden = false
        }
    }
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
            return optionArray.count
        }else{
            return employerOption.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableCell
        if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
            cell.tableLabel.text = optionArray[indexPath.row]
        }else{
            cell.tableLabel.text = employerOption[indexPath.row]
        }
            cell.selectionStyle = .none
        return cell
    }
///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
///
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            vc.profileData = profileData
            self.navigationController?.pushViewController(vc, animated: true)
///
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
///
        case 2:
            if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyApplicationVC") as! MyApplicationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyJobVC") as! MyJobVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
///
        case 3:
            if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "FavoriteVC") as! FavoriteVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.showAlertWithTwoActions(alertTitle:"Sign Out", message: "Do you want to sign out?", action1Title: "Yes", action1Style: .destructive, action2Title: "No") { yes in
                    UserDefaults.standard.removeObject(forKey: "userId")
                    UserDefaults.standard.removeObject(forKey: "token")
                    UserDefaults.standard.removeObject(forKey: "type")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LandingScreenVC") as! LandingScreenVC
                    self.navigationController?.pushViewController(vc, animated: true)
                } completion2: { no in
                    print("not logged out")
                }
            }
///
        case 4:
            if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
                self.showAlertWithTwoActions(alertTitle:"Sign Out", message: "Do you want to sign out?", action1Title: "Yes", action1Style: .destructive, action2Title: "No") { yes in
                    UserDefaults.standard.removeObject(forKey: "userId")
                    UserDefaults.standard.removeObject(forKey: "token")
                    UserDefaults.standard.removeObject(forKey: "type")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LandingScreenVC") as! LandingScreenVC
                    self.navigationController?.pushViewController(vc, animated: true)
                } completion2: { no in
                    print("not logged out")
                }
            }else{
                self.showAlertWithTwoActions(alertTitle: "Delete Account", message: "Your account will be permanantly removed from app you have to register again are you sure you want to delete account?", action1Title: "Yes", action1Style: .destructive, action2Title: "Cancel") { yes in
                ApiManager.shared.deleteUser(userid: self.userid, token: self.token) { isSuccess in
                    if isSuccess{
                        UserDefaults.standard.removeObject(forKey: "userId")
                        UserDefaults.standard.removeObject(forKey: "token")
                        UserDefaults.standard.removeObject(forKey: "type")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LandingScreenVC") as! LandingScreenVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        self.alert(message: ApiManager.shared.message)
                    }
                }
                }completion2: { cancel in
                    print("Hello")
                }
            }
///
        case 5:
            self.showAlertWithTwoActions(alertTitle: "Delete Account", message: "Your account will be permanantly removed from app you have to register again are you sure you want to delete account?", action1Title: "Yes", action1Style: .destructive, action2Title: "Cancel") { yes in
            ApiManager.shared.deleteUser(userid: self.userid, token: self.token) { isSuccess in
                if isSuccess{
                    UserDefaults.standard.removeObject(forKey: "userId")
                    UserDefaults.standard.removeObject(forKey: "token")
                    UserDefaults.standard.removeObject(forKey: "type")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LandingScreenVC") as! LandingScreenVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: ApiManager.shared.message)
                }
            }
            }completion2: { cancel in
                print("Hello")
            }

///
        default:
            print("hello")
        }
    }
    
}


extension ProfileVC{
    func getProfile(){
       userid = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
        token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
        ApiManager.shared.getProfile(userId: userid) {[self] profile,isSuccess in
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
        if let image = profileData.imageUrl {
            let url = URL(string: image)
            if url != nil{
                self.profileImage.af.setImage(withURL: url!)
            }else{
                self.profileImage.image = UIImage(named: "")
            }
        }
        
    }
}


