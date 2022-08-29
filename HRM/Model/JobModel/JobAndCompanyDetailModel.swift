//
//  JobAndCompanyDetailModel.swift
//  HRM
//
//  Created by Macbook Air (ios) on 31/05/22.
//

import UIKit
import SwiftyJSON

class JobAndCompanyDetailModel: NSObject {

    var company =  CompanyDetails()
    var user = User()
    var category = Category()
    
    var title:String? = ""
    var location: String? = ""
    var priceFrom: Int? = 0
    var priceTo: Int? = 0
    var workers: Int? = 0
    //
    var jobType: String? = ""
    var firstName: String? = ""
    var lastName: String? = ""
    var email: String? = ""
    var country: String? = ""
    var scopeOfWork: String? = ""
    var planOfAction: String? = ""
    var contructionDocumentation: String? = ""
    var id: String? = ""
    
    convenience init(_ data: JSON){
        self.init()
        title = data["title"].stringValue
        location = data["location"].stringValue
        priceFrom = data["priceFrom"].intValue
        priceTo = data["priceTo"].intValue
        workers = data["workers"].intValue
        jobType = data["jobType"].stringValue
        firstName = data["firstName"].stringValue
        lastName = data["lastName"].stringValue
        email = data["email"].stringValue
        country = data["country"].stringValue
        scopeOfWork = data["scopeOfWork"].stringValue
        planOfAction = data["planOfAction"].stringValue
        contructionDocumentation = data["constructionDocumentation"].stringValue
        id = data["_id"].stringValue
        company = CompanyDetails(data["company"])
        user = User(data["user"])
        category = Category(data["category"])        
    }
}


class CompanyDetails: NSObject{
    var address:String? = ""
    var email: String? = ""
    var experience: String? = ""
    var phoneNumber: String? = ""
    var skills: String? = ""
    
   convenience init(_ data : JSON){
       self.init()
       address = data["address"].stringValue
       email = data["emailId"].stringValue
       experience = data["experience"].stringValue
       phoneNumber = data["phoneNumber"].stringValue
       skills = data["skills"].stringValue

    }
}

class User: NSObject{
    
    var companyName:String? = ""
    var email: String? = ""
    var image: String? = ""
    var phoneNumber: String? = ""
    var roleType: String? = ""
    var userName: String? = ""
    var userId: String? = ""
    
    convenience init(_ data : JSON){
        self.init()
        companyName = data["companyName"].stringValue
        email = data["email"].stringValue
        image = data["image"].stringValue
        phoneNumber = data["phoneNumber"].stringValue
        roleType = data["roleType"].stringValue
        userName = data["userName"].stringValue
        userId = data["_id"].stringValue
     }
    
}

class Category: NSObject{
    var categoryName: String? = ""
    var categoryId: String? = ""
    
    convenience init(_ data : JSON){
        self.init()
        categoryName = data["category"].stringValue
        categoryId = data["_id"].stringValue
     }
}
