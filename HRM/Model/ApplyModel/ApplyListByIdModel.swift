//
//  ApplyListByIdModel.swift
//  HRM
//
//  Created by MacBook M1 on 14/06/22.
//

import UIKit
import SwiftyJSON

class ApplyListByIdModel: NSObject{
   
    var firstName: String? = ""
    var lastName: String? = ""
    var email: String? = ""
    var country: String? = ""
    var describe: String? = ""
    var resume: String? = ""
    var status: String? = ""
    var postedBy: String? = ""
    var applyBy = User()
    var job = JobData()
    
    convenience init(_ data: JSON) {
        self.init()
    
        firstName = data["firstName"].stringValue
        lastName = data["lastName"].stringValue
        email = data["email"].stringValue
        country = data["country"].stringValue
        describe = data["describe"].stringValue
        resume = data["resume"].stringValue
        status = data["status"].stringValue
        postedBy = data["postedBy"].stringValue
        job = JobData(data["job"])
        applyBy = User(data["applyBy"])
    }
}


class JobData: NSObject {
    
    var company =  CompanyDetails()
    
    
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
    var user:String? = ""
    var category: String? = ""
    
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
        contructionDocumentation = data["contructionDocumentation"].stringValue
        id = data["_id"].stringValue
        user = data["user"].stringValue
        category = data["category"].stringValue
        company = CompanyDetails(data["company"])

    }
}
