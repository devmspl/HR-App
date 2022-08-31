//
//  LoginVC.swift
//  HRM
//
//  Created by M1 on 08/04/22.
//

import UIKit
import GoogleSignIn
import ARSLineProgress
import AuthenticationServices

class LoginVC: UIViewController,GIDSignInDelegate, ASAuthorizationControllerDelegate {
    
    

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var socialId = ""
    var firstname = ""
    var avatar = ""
    var emailTex = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        password.isSecureTextEntry = true
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func onLoginWithGoogleTap(_ sender: Any) {
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func onAppleLogin(_ sender: Any) {
        let appledetails = ASAuthorizationAppleIDProvider()
               let request = appledetails.createRequest()
               request.requestedScopes = [.email , .fullName]
               let controller  = ASAuthorizationController(authorizationRequests: [request])
               controller.delegate = self
               controller.performRequests()
    }
    @IBAction func onLoginTap(_ sender: Any) {
        let loginModel = loginModel(email: email.text!, password: password.text!)
        ApiManager.shared.loginApi(model: loginModel) { response,isSuccess in
            if isSuccess{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    @IBAction func onForgotPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onCreateAccount(_ sender: Any) {
        if UserDefaults.standard.value(forKey: "type") as! String == "employee"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeSignUpVC") as! EmployeeSignUpVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmployerSignUpVC") as! EmployerSignUpVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
    @IBAction func onShowPassword(_ sender: Any) {
        if password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    
}
//MARK: - social logins
extension LoginVC{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
                    socialId = user.userID
                    firstname = "\(user.profile.givenName!) \(user.profile.familyName!)"
                    emailTex = user.profile.email!
                    avatar = "\(user.profile.imageURL(withDimension: 480))"
                    socialLogin(platform: "G")
                }
    }

    func socialLogin(platform: String){
        let model = SocialLogin(socialLinkId: socialId, platform: platform, email: emailTex, userName: firstname,roleType: UserDefaults.standard.value(forKey: "type") as? String ?? "", phoneNumber: "0000")
        print("model",model)
        ARSLineProgress.show()
        
        ApiManager.shared.socialLogin(model: model) { isSuccess,result in
            ARSLineProgress.hide()
            if isSuccess{
                if platform == "Apple"{
                    let email = result?.object(forKey: "email") as! String
                    let username = result?.object(forKey: "userName") as! String
                    UserDefaults.standard.setValue(email, forKey: "email")
                    UserDefaults.standard.setValue(username, forKey: "username")
                }
            
                ARSLineProgress.hide()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                ARSLineProgress.hide()
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    
    
  
        @available(iOS 13.0, *)
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print(error.localizedDescription)
        }
        
        @available(iOS 13.0, *)
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let details  = authorization.credential as? ASAuthorizationAppleIDCredential {
                print(details.user)
                socialId = "\(details.user)"
                print(details.fullName!)
                firstname = details.fullName?.givenName ?? "\(UserDefaults.standard.value(forKey: "username") as! String)"
                emailTex = details.email ?? "\(UserDefaults.standard.value(forKey: "email") as! String)"
                //lastname = details.fullName?.familyName ?? "user"
                  socialLogin(platform: "Apple")
              //  Signin()
               
            }
        }
    
    
}
