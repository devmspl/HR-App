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
                        let userName = data.object(forKey: "userName") as! String
                        let token = response.response?.allHeaderFields["x-access-token"] as! String
                        UserDefaults.standard.setValue(id, forKey: "userId")
                        UserDefaults.standard.setValue(userName, forKey: "username")
                        UserDefaults.standard.setValue(token, forKey: "token")
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
//MARK: - DELETE USER
    func deleteUser(userid: String,token: String,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let header: HTTPHeaders = ["x-access-token":token]
            AF.request(ApiUrls.deleteUser+userid,method: .delete,headers: header).response{
                response in
                switch (response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    print(respond)
                    if response.response?.statusCode == 200{
                       
                        print("deleted")
                        completion(true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        print("error occured")
                        completion(false)
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                case .failure(let error): do{
                    completion(false)
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(false)
        }
    }
//MARK: - socialLogin
    func socialLogin(model: SocialLogin,completion: @escaping(Bool,NSDictionary?)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("URL: - \(ApiUrls.socialLogin)")
            AF.request(ApiUrls.socialLogin,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!)
                    let respond = json as! NSDictionary
                    print("respond",respond)
                    if response.response?.statusCode == 200{
                        let data = respond.object(forKey: "data") as! NSDictionary
                        let userid = data.object(forKey: "_id") as! String
                        let token = response.response?.allHeaderFields["x-access-token"] as! String
                        let userName = data.object(forKey: "userName") as! String
                        UserDefaults.standard.setValue(userid, forKey: "userId")
                        UserDefaults.standard.setValue(userName, forKey: "username")
                        UserDefaults.standard.setValue(token, forKey: "token")
                        print("Logged In successfully")
                        completion(true,data)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        print(self.message)
                        completion(false,nil)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false,nil)
                }
                case .failure(let error): do{
                    print(error.localizedDescription)
                    completion(false,nil)
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(false,nil)
        }
    }
    
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
          
    //MARK: - otp Api
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
//MARK: - update user api
    func updateUserApi(model:updateProfileModel,completion: @escaping (NSDictionary,Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let id = UserDefaults.standard.object(forKey: "userId") as! String
            let token = UserDefaults.standard.object(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token":token]
            print("Url:- \(ApiUrls.updateUser+id)")
            AF.request(ApiUrls.updateUser+id,method: .put,parameters: model,encoder: JSONParameterEncoder.default,headers: head).response{ [self]
                response in
                switch(response.result){
                    
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:[])
                    let statusCode = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if statusCode == 200{
                        print(respond)
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
    
    
//MARK: - create job api
        func createJob(model: CreateJobModel,completion: @escaping(Bool,String)->()){
            if ReachabilityNetwork.isConnectedToNetwork(){
                print("URL: - \(ApiUrls.jobCreate)")
                AF.request(ApiUrls.jobCreate,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                    response in
                    switch(response.result){
                    case .success(let data): do{
                        let json = try JSONSerialization.jsonObject(with: data!)
                        let respond = json as! NSDictionary
                        print("respond",respond)
                        if response.response?.statusCode == 200{
                            print("Job successfully created")
                            let data = respond.object(forKey: "data") as! NSDictionary
                            let id = data.object(forKey: "_id") as! String
                            completion(true,id)
                        }else{
                            self.message = respond.object(forKey: "error") as! String
                            print(self.message)
                            completion(false,"")
                        }
                    }catch{
                        print(error.localizedDescription)
                        completion(false,"")
                    }
                    case .failure(let error): do{
                        print(error.localizedDescription)
                        completion(false,"")
                    }
                    }
                }
            }else{
                self.message = "Please check internet connection"
                completion(false,"")
            }
        }
//MARK: -
    func updateJob(userId: String,model: CreateJobModel,completion: @escaping(Bool)->()){
            if ReachabilityNetwork.isConnectedToNetwork(){
                print("URL: - \(ApiUrls.updatejob+userId)")
                AF.request(ApiUrls.updatejob+userId,method: .put,parameters: model,encoder: JSONParameterEncoder.default).response{
                    response in
                    switch(response.result){
                    case .success(let data): do{
                        let json = try JSONSerialization.jsonObject(with: data!)
                        let respond = json as! NSDictionary
                        print("respond",respond)
                        if response.response?.statusCode == 200{
                            print("Job successfully created")
                            completion(true)
                        }else{
                            self.message = respond.object(forKey: "error") as! String
                            print(self.message)
                            completion(false)
                        }
                    }catch{
                        print(error.localizedDescription)
                        completion(false)
                    }
                    case .failure(let error): do{
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

 //MARK: - popular job
    func popularJobs(completion: @escaping ([JobDetailModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.popularJobs)")
            AF.request(ApiUrls.popularJobs,method: .get).response{ [self]
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
                    }else{
                        message = respond.object(forKey: "error") as! String
                        completion([],true)
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
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],true)
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
//MARK: - get job by user
    func getJobByUserId(userId: String,completion: @escaping ([JobAndCompanyDetailModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.createdJob+userId)")
            AF.request(ApiUrls.createdJob+userId,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [JobAndCompanyDetailModel]()
                        for i in data{
                            jobArray.append(JobAndCompanyDetailModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],false)
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
//MARK: - GET APLLIED USER DATA
    func getAppliedUserDetails(userId: String,applyid: String,completion: @escaping (ApplicantModel?,Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.applicantData+userId+"/\(applyid)")")
            AF.request(ApiUrls.applicantData+userId+"/\(applyid)",method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [String: Any]
                       
                    completion(ApplicantModel.init(JSON(data)),true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(nil,false)
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
//MARK: - GET ALL APPLIED JOBS

    func getJobApplications(jobId: String,completion: @escaping ([ApplicantsDataModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.createdJob+jobId)")
            AF.request(ApiUrls.jobApplicants+jobId,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [ApplicantsDataModel]()
                        for i in data{
                            jobArray.append(ApplicantsDataModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],false)
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
// MARK: - GETALL USERS
    func getAllUsers(completion: @escaping ([User],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.getAllUsers)")
            let token = UserDefaults.standard.object(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token":token]
            AF.request(ApiUrls.getAllUsers,method: .get,headers: head).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if success == 200{
                        let data = respond.object(forKey: "message") as! [[String: Any]]
                        var jobArray = [User]()
                        for i in data{
                            jobArray.append(User.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],false)
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

//MARK: - get all jobs
    func getAllJobs(completion: @escaping ([JobAndCompanyDetailModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.getAllJobs)")
            AF.request(ApiUrls.getAllJobs,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [JobAndCompanyDetailModel]()
                        for i in data{
                            jobArray.append(JobAndCompanyDetailModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],false)
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
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(nil,true)
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
    func jobApplyApi(model: JobApplyModel,completion: @escaping(Bool,String)->()){
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
                        let data = respond.object(forKey: "data") as! NSDictionary
                        let id = data.object(forKey: "_id") as! String
                        completion(true,id)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(false,"")
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false,"")
                }
                case .failure(let error):do{
                    print(error.localizedDescription)
                    completion(false,"")
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(false,"")
        }
        
    }
//MARK: - universal doc upload api
    func uploadfile(apiURL: String,dataObj: URL,strfilename: String,progressCompletion: @escaping (_ percent: Float) -> Void,

                        completion: @escaping (_ result: [String: Any]?, _ error: AFError?) -> Void) {
           AF.upload(
                   multipartFormData: { multipartFormData in
//                       for (key,value) in parms{
//
//                           if let temp = value as? String{
//
//                               multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//
//                           }
//                       }
                     multipartFormData.append(dataObj,
                                              withName: "file",
                                              fileName: strfilename,
                                              mimeType: "application/pdf")
                   },
                   to: apiURL, usingThreshold: UInt64.init(), method: .put)
                   .uploadProgress { progress in
                        progressCompletion(Float(progress.fractionCompleted))
                   }
                   .responseJSON { response in
                       switch response.result{
                       case .success(let json): do {
                               print("success===",json)
                               let statusCode = response.response?.statusCode
                               if(statusCode == 201)
                               {
                                   let response = json as! [String: Any]
                                   completion(response,nil)
                                   print(response)
                               }else{
                                   print("error")
                               }
                           }
                       case.failure(let error):
                           print(error)
                           completion(nil,error)
                       }
                   }
               }
    
//MARK: - apply/list by userid
    func applyListByUserId(id: String,completion: @escaping ([ApplyListByIdModel?],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.jobApplyList+id)")
            AF.request(ApiUrls.jobApplyList+id,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [ApplyListByIdModel]()
                        for i in data{
                            jobArray.append(ApplyListByIdModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],true)
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
//MARK: - get all appply jobs
    func getAllApplyJob(completion: @escaping ([ApplyListByIdModel?],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.allApplyJobs)")
            AF.request(ApiUrls.allApplyJobs,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [ApplyListByIdModel]()
                        for i in data{
                            jobArray.append(ApplyListByIdModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],true)
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
//MARK: - delete job api
    func deleteJobApi(jobId: String,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("URL: - \(ApiUrls.deletejob+jobId)")
            AF.request(ApiUrls.deletejob+jobId,method: .delete).responseJSON { response in
                switch(response.result){
                case .success(let json): do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if status == 200{
                        print("success")
                        completion(true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }
                
                case .failure(let error):do{
                    print("error",error)
                    completion(false)
                }
                }
            }
        }else{
            self.message = "Please check internet connection"
            completion(false)
        }
    }
//MARK: - job search api
    func jobSearchApi(text: String,completion: @escaping([JobData],Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(ApiUrls.searchJob+text)
            AF.request(ApiUrls.searchJob+text,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if status == 200{
                        let data = respond.object(forKey: "message") as! [[String:Any]]
                        var jobData = [JobData]()
                        for i in data{
                            jobData.append(JobData.init(JSON(i)))
                        }
                        completion(jobData,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion([],false)
                }
                case .failure(let error): do{
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
//MARK: - job filter api
    func jobFilter(queryString: String,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(ApiUrls.jobFilter+queryString,method: .get).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if status == 200{
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
//MARK: - createwishlist api
    func createWishlist(model: CreateWishlistModel,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            print("URL: - \(ApiUrls.createWishlist)")
            AF.request(ApiUrls.createWishlist,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!)
                    let respond = json as! NSDictionary
                    print("respond",respond)
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
                case .failure(let error): do{
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
//MARK: - get wishlist
    func getWishlistApi(userid: String,completion: @escaping ([GetWishlistModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.getWishlist+userid)")
            AF.request(ApiUrls.getWishlist+userid,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [GetWishlistModel]()
                        for i in data{
                            jobArray.append(GetWishlistModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],true)
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
//MARK: - delete wishlist api
    func deleteWishlist(wishlistId: String,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(ApiUrls.deleteWishlist+wishlistId,method: .delete).response{
                response in
                switch (response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
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
//MARK: - getCategories
    func getAllCategories(completion: @escaping ([GetCategoryModel],Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print("Url:- \(ApiUrls.getAllCategory)")
            AF.request(ApiUrls.getAllCategory,method: .get).response{
                response in
                switch(response.result){
                case .success(let data): do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if success == 200{
                        let data = respond.object(forKey: "data") as! [[String: Any]]
                        var jobArray = [GetCategoryModel]()
                        for i in data{
                            jobArray.append(GetCategoryModel.init(JSON(i)))
                        }
                        completion(jobArray,true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion([],true)
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
//MARK: - get category by id
    func getCategoryById(categoryId: String,completion: @escaping(GetCategoryModel?,Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(ApiUrls.getCatogeryById, method: .get).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if status == 200{
                        let data = respond.object(forKey: "data") as! [String:Any]
                        completion(GetCategoryModel.init(JSON(data)),true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(nil,false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil,false)
                }
                case .failure(let error): do{
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
//MARK: - create categories
    func createCategory(categoryname: String,completion: @escaping(Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(ApiUrls.createCategory," - createCategories")
            let para: [String:Any] = [
                "category":categoryname
            ]
            AF.request(ApiUrls.createCategory,method: .post,parameters: para,encoding: JSONEncoding.default).responseJSON{
                response in
                switch(response.result){
                case .success(let json): do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if status == 200{
                        print("categoryCreated")
                        completion(true)
                    }else{
                        self.message = respond.object(forKey: "error") as! String
                        completion(false)
                    }
                }
                case .failure(let error): do{
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
//MARK: - image upload single
    func uploadSingleImage(image: UIImage,
                progressCompletion: @escaping (_ percent: Float) -> Void,
                completion: @escaping (_ result: Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        let randomno = Int.random(in: 1000...100000)
        let imgFileName = "image\(randomno).jpg"
        let userId = UserDefaults.standard.value(forKey: "userId") as! String
        AF.upload(
            multipartFormData: { multipartFormData in
                //
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: imgFileName,
                                         mimeType: "image/jpeg")
                multipartFormData.append((userId.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "id")
            },
            to: ApiUrls.imageSingleUpload, usingThreshold: UInt64.init(), method: .post)
            .uploadProgress { progress in
                progressCompletion(Float(progress.fractionCompleted))
            }
            .response { response in
                debugPrint(response)
            }
    }
//MARK: - image upload multiple
    func uploadMultipleImages(image: [UIImage],progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
//              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//              print("Could not get JPEG representation of UIImage")
//              return
//            }
            let randomno = Int.random(in: 1000...100000)
           let imgFileName = "image\(randomno).jpg"
        let userId = UserDefaults.standard.object(forKey: "userId") as! String
            AF.upload(
              multipartFormData: { multipartFormData in
                for i in 0...image.count-1{
                    multipartFormData.append(image[i].jpegData(compressionQuality: 0.5)!,
                                             withName: "files[]",
                                             fileName: imgFileName,
                                             mimeType: "image/jpeg")
                              }
               },
              to:  ApiUrls.imageMultipleUpload+userId, usingThreshold: UInt64.init(), method: .put)
              .uploadProgress { progress in
                   progressCompletion(Float(progress.fractionCompleted))
              }
              .response { response in
                  debugPrint(response)
              }
          }
    
    //MARK: - profileImageUpload
    func uploadProfileImage(image: UIImage,
                progressCompletion: @escaping (_ percent: Float) -> Void,
                completion: @escaping (_ result: Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        let randomno = Int.random(in: 1000...100000)
        let imgFileName = "image\(randomno).jpg"
        let userId = UserDefaults.standard.value(forKey: "userId") as! String
        AF.upload(
            multipartFormData: { multipartFormData in
                //
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: imgFileName,
                                         mimeType: "image/jpeg")
                multipartFormData.append((userId.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "id")
            },
            to: ApiUrls.uploadprofileImage, usingThreshold: UInt64.init(), method: .post)
            .uploadProgress { progress in
                progressCompletion(Float(progress.fractionCompleted))
            }
            .response { response in
                debugPrint(response)
            }
    }
    
//MARK: - old chat
    func oldChatApi(roomId: String,completion: @escaping([OldChatModel],Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(ApiUrls.oldChat+roomId+"&pageNo=1"+"&pageSize=100000","dscdsacasdc")
        AF.request(ApiUrls.oldChat+roomId+"&pageNo=1"+"&pageSize=100000",method: .get).response { response in
            switch (response.result){
            case .success(let data): do{
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let respond = json as! NSDictionary
                print(respond)
                if response.response?.statusCode == 200{
                    let data = respond.object(forKey: "items") as! [[String:Any]]
                    var chatData = [OldChatModel]()
                    for i in data{
                        chatData.append(OldChatModel.init(JSON(i)))
                    }
                    completion(chatData,true)
                }else{
                    self.message = respond.object(forKey: "error") as! String
                    completion([],false)
                }
            }catch{
                print(error.localizedDescription)
                completion([],false)
            }
            case .failure(let error): do{
                print(error,error)
                completion([],false)
            }
            }
        }
        }else{
            self.message = "Please check internet connection"
        }
    }
    
}


