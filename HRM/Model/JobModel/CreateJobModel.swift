//
//  CreateJobModel.swift
//  HRM
//
//  Created by MacBook M1 on 14/06/22.
//

import Foundation

struct CreateJobModel: Encodable{
    let title:String?
    let categoryId: String?
    let userId: String?
    let location: String?
    let priceFrom: Int?
    let priceTo: Int?
    let workers: Int?
    let jobType: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let country: String?
    let scopeOfWork: String?
    let planOfAction: String?
    let contructionDocumentation: String?
    let company:CompanyDat?
}

struct CompanyDat: Encodable{
    var address:String? = ""
    var emailId: String? = ""
    var experience: String? = ""
    var phoneNumber: String? = ""
    var skills: String? = ""
}
