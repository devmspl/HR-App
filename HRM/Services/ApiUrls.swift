//
//  ApiUrls.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import Foundation

public var BaseUrl = "http://93.188.167.68:9090/api/"

public struct ApiUrls {
 //MARK: - USER API
    public static var loginApi                    = BaseUrl + "users/login"
    public static var signUp                      = BaseUrl + "users/register"
    public static var forgetPassword              = BaseUrl + "users/forgotPassword"
    public static var otp                         = BaseUrl + "users/otpVerifyAndChangePassword"
    public static var resetPassword               = BaseUrl + "users/newPassword"
    public static var getProfile                  = BaseUrl + "users/currentUser/"
//    users/currentUser/
//MARK: -  jobApi
    public static var popularJobs                 = BaseUrl + "jobs/getpopularjobs"
    public static var recentJobs                  = BaseUrl + "jobs/recentPosts"
    public static var jobDetails                  = BaseUrl + "jobs/getJobs/"
    public static var jobApply                    = BaseUrl + "apply/create"
    
}
