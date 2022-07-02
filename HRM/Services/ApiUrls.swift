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
//    public static var socialLogin                 = BaseUrl + "users/socialLogin"
    public static var signUp                      = BaseUrl + "users/register"
    public static var forgetPassword              = BaseUrl + "users/forgotPassword"
    public static var otp                         = BaseUrl + "users/otpVerifyAndChangePassword"
    public static var resetPassword               = BaseUrl + "users/newPassword"
    public static var getProfile                  = BaseUrl + "users/currentUser/"
    public static var updateUser                  = BaseUrl + "users/update/"
    public static var uploadprofileImage          = BaseUrl + "users/uploadImage"
    
//    users/uploadImage
//MARK: -  jobApi
    public static var popularJobs                 = BaseUrl + "jobs/getpopularjobs"
    public static var recentJobs                  = BaseUrl + "jobs/recentPosts"
    public static var jobDetails                  = BaseUrl + "jobs/getJobs/"
    public static var jobCreate                   = BaseUrl + "jobs/create"
    public static var getAllJobs                  = BaseUrl + "jobs/create"
    public static var updatejob                   = BaseUrl + "jobs/update/"
    public static var deletejob                   = BaseUrl + "jobs/deleteJobs/"
    public static var searchJob                   = BaseUrl + "jobs/search"
    public static var jobFilter                   = BaseUrl + "jobs/jobsFilter"
    
//MARK: - Apply api
    public static var jobApply                    = BaseUrl + "apply/create"
    public static var jobApplyList                = BaseUrl + "apply/listByUserId/"
    public static var allApplyJobs                = BaseUrl + "apply/getAllJobsApply"
        
//MARK: - wishlist
    public static var createWishlist              = BaseUrl + "wishlist/create"
    public static var getWishlist                 = BaseUrl + "wishlist/wishlistByUserId/"

//MARK: - category
    public static var getAllCategory              = BaseUrl + "category/getAllCategory"
    public static var createCategory              = BaseUrl + "category/create"
    public static var getCatogeryById             = BaseUrl + "category/getCategory/"
    
//MARK: - image api's
    public static var imageSingleUpload           = BaseUrl + "images/uploadSingle"
    public static var imageMultipleUpload         = BaseUrl + "images/uploadMultiple/"
    public static var getFile                     = BaseUrl + "images/getFile/"
    
}
