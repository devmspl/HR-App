//
//  ApiManager.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiManager: UIViewController {

    public static var shared = ApiManager()
    var message = ""
    
//MARK: - SIGNUP API
    func signUpApi(model:signUpModel,completion: @escaping (NSDictionary,Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.signUp)")
            AF.request(ApiUrls.signUp,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:[])
                    let statusCode = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if statusCode == 200{
                        print(respond)
                        message = respond.object(forKey: "message") as! String
                        completion(respond,true)
                    }else{
                        print(respond)
                        message = respond.object(forKey: "error") as! String
                        completion(NSDictionary(),false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(NSDictionary(),false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(NSDictionary(),false)
                }
                }
            }
        }else{
            message = "Please check internet connection"
            completion(NSDictionary(),false)
        }
        }
      
//MARK: - Login Api
    func loginApi(model:loginModel,completion: @escaping (NSDictionary,Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.loginApi)")
            AF.request(ApiUrls.loginApi,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:[])
                    let statusCode = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if statusCode == 200{
                        print(respond)
                        message = respond.object(forKey: "message") as! String
                        let data = respond.object(forKey: "data") as! NSDictionary
                        let id = data.object(forKey: "_id") as! String
                        let token = response.response?.allHeaderFields["x-access-token"] as! String
                        UserDefaults.standard.set(id, forKey: "userId")
                        UserDefaults.standard.set(token, forKey: "token")
                        completion(respond,true)
                    }else{
                        print(respond)
                        message = respond.object(forKey: "error") as! String
                        completion(NSDictionary(),false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(NSDictionary(),false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(NSDictionary(),false)
                }
                }
            }
        }else{
            completion(NSDictionary(),false)
        }
        }
    //
    //MARK: - Forget Password
        func forgetPasswordApi(model:forgetPassword,completion: @escaping (NSDictionary,Bool) -> ()){
            if ReachabilityNetwork.isConnectedToNetwork(){
                print("Url:- \(ApiUrls.forgetPassword)")
                AF.request(ApiUrls.forgetPassword,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{ [self]
                    response in
                    switch(response.result){
                        
                    case .success(let data):do{
                        let json = try JSONSerialization.jsonObject(with: data!, options:[])
                        let statusCode = response.response?.statusCode
                        let respond = json as! NSDictionary
                        if statusCode == 200{
                            print(respond)
                            message = respond.object(forKey: "message") as! String
                            let data = respond.object(forKey: "data") as! NSDictionary
                            let token = data.object(forKey: "token") as! String
                            UserDefaults.standard.set(token, forKey: "token")
                            completion(respond,true)
                        }else{
                            print(respond)
                            message = respond.object(forKey: "error") as! String
                            completion(NSDictionary(),false)
                        }
                    }catch{
                        print(error.localizedDescription)
                        completion(NSDictionary(),false)
                    }
                    case .failure(let error):do{
                        print(error.localizedDescription)
                        completion(NSDictionary(),false)
                    }
                    }
                }
            }else{
                message = "Please check internet connection"
                completion(NSDictionary(),false)
            }
            }
          
    //MARK: - Login Api
        func otpApi(model:otpModel,completion: @escaping (NSDictionary,Bool) -> ()){
            if ReachabilityNetwork.isConnectedToNetwork(){
                let token = UserDefaults.standard.value(forKey: "token") as! String
                let head: HTTPHeaders = ["x-access-token": token]
                print("Url:- \(ApiUrls.otp)")
                AF.request(ApiUrls.otp,method: .post,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{ [self]
                    response in
                    switch(response.result){
                        
                    case .success(let data):do{
                        let json = try JSONSerialization.jsonObject(with: data!, options:[])
                        let statusCode = response.response?.statusCode
                        let respond = json as! NSDictionary
                        if statusCode == 200{
                            print(respond)
                            message = respond.object(forKey: "message") as! String
                            completion(respond,true)
                        }else{
                            print(respond)
                            message = respond.object(forKey: "error") as! String
                            completion(NSDictionary(),false)
                        }
                    }catch{
                        print(error.localizedDescription)
                        completion(NSDictionary(),false)
                    }
                    case .failure(let error):do{
                        print(error.localizedDescription)
                        completion(NSDictionary(),false)
                    }
                    }
                }
            }else{
                
                completion(NSDictionary(),false)
            }
            }
 //MARK: - RESET PASSWORD
    func resetPasswordApi(model:resetPasswordModel,completion: @escaping (NSDictionary,Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token": token]
            print("Url:- \(ApiUrls.resetPassword)","Token: - \(token)")
            AF.request(ApiUrls.resetPassword,method: .put,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:[])
                    let statusCode = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if statusCode == 200{
                        print(respond)
                        message = respond.object(forKey: "message") as! String
                        completion(respond,true)
                    }else{
                        print(respond)
                        message = respond.object(forKey: "error") as! String
                        completion(NSDictionary(),false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(NSDictionary(),false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(NSDictionary(),false)
                }
                }
            }
        }else{
            
            completion(NSDictionary(),false)
        }
        }
    
 //MARK: - get userprofile
    func getProfile(userId: String,completion: @escaping(GetProfileModel?,Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.getProfile+userId)")
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token": token]
            AF.request(ApiUrls.getProfile+userId,method: .get,headers: head).response{[self] response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    print(respond)
                    if response.response?.statusCode == 200 {
                        let data = respond.object(forKey: "data") as! [String:Any]
                        completion(GetProfileModel.init(JSON(data)),true)
                    }else{
                        message = respond.object(forKey: "error") as! String
                        completion(nil,false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil,false)
                }
                case .failure(let error): do{
                    print(error)
                    completion(nil,false)
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(nil,false)
        }
       
    }
    
 //MARK: - popular job
    func popularJobs(completion: @escaping ([JobDetailModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.popularJobs)")
            AF.request(ApiUrls.popularJobs,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "message") as! [[String: Any]]
                        var jobArray = [JobDetailModel]()
                        for i in data{
                            jobArray.append(JobDetailModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion([],false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion([],false)
                }
                }
            
            }
        }else{
            self.message = "Please check internet connection"
            completion([],false)
        }
    }
//MARK: - recentJobs
    func recentJobs(completion: @escaping ([JobDetailModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.recentJobs)")
            AF.request(ApiUrls.recentJobs,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "message") as! [[String: Any]]
                        var jobArray = [JobDetailModel]()
                        for i in data{
                            jobArray.append(JobDetailModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion([],false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion([],false)
                }
                }
            
            }
        }else{
            self.message = "Please check internet connection"
            completion([],false)
        }
    }
//MARK: -  getJobdetail by id Api
    func jobDetailById(id: String,completion: @escaping (JobAndCompanyDetailModel?,Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.jobDetails+id)")
            AF.request(ApiUrls.jobDetails+id,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [String:Any]
                        
                        completion(JobAndCompanyDetailModel.init(JSON(data)),true)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil,false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(nil,false)
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(nil,false)
        }
    }

//MARK: -  apply job api
    func jobApplyApi(model: JobApplyModel,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.jobApply)")
            AF.request(ApiUrls.jobApply,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    print(respond)
                    if response.response?.statusCode == 200{
                        completion(true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false)
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(false)
        }
        
    }
}
