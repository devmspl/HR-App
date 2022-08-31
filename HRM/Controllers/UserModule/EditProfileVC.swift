//
//  EditProfileVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/05/22.
//

import UIKit
import AlamofireImage

class EditProfileVC: BaseClass {
///
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
///
    var profileData = GetProfileModel()
///
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        view.overrideUserInterfaceStyle = .light
        email.isUserInteractionEnabled = false
         
    }
///
    //MARK: - actions
    @IBAction func onBackTap(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadImage(_sender : UIButton){
    
        
        openCameraAndPhotos(isEditImage: true) { image, abc in
            self.profileImage.image = image
            self.uploadImage()
        } failure: { str in
            self.alert(message: str)
        }

    }
    @IBAction func onSaveTap(_ sender:UIButton){
        if name.text == "" {
            alert(message: "Please enter name")
        }else if contact.text == ""{
        alert(message: "Please enter contact")
        }else{
            updateUser()
        }
    }
}
///
//MARK: - extension
extension EditProfileVC{
    func updateUser(){
        let model = updateProfileModel(userName: name.text!, companyName: "", phoneNumber: contact.text!, email: email.text!)
        ApiManager.shared.updateUserApi(model: model) { response, isSuccess in
            if isSuccess{
                self.showAlertWithOneAction(alertTitle: "Profile", message: "Profile successfully updated", action1Title: "Ok") { ok in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    func uploadImage(){
        ApiManager.shared.uploadProfileImage(
            image: self.profileImage.image!,
                    progressCompletion: { [weak self] percent in
                       guard let _ = self else {
                         return
                       }
                       print("Status: \(percent)")
                      if percent == 1.0{
                     self!.alert(message: "Profile updated Successfully", title: "Image")
                      }else{
                          print("not updated")
                      }
                     },
                     completion: { [weak self] result in
                       guard let _ = self else {
                         return
                       }
                   })
    }
    
    func  getdata(){
        self.name.text = profileData.name
        self.email.text = profileData.email
        self.contact.text = profileData.number
        self.userName.text = profileData.name
        if let image = profileData.imageUrl {
            let url = URL(string: image)
            if url != nil{
                self.profileImage.af.setImage(withURL: url!)
            }else{
                print("hello")
            }
        }
    }
}
