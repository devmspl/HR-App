//
//  ApplicantDataModel.swift
//  HRM
//
//  Created by MacBook M1 on 03/08/22.
//

import UIKit
import SwiftyJSON
class ApplicantsDataModel: NSObject {

    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var country: String?
    var describe: String?
    var resume: String?
    var status: String?
    var applyBy: User?
    var job: JobData?
    var postedBy: User?
    var date: String?
    convenience  init(_ data: JSON) {
        self.init()
        self.id = data["id"].stringValue
        self.firstName = data["firstName"].stringValue
        self.lastName = data["lastName"].stringValue
        self.email = data["email"].stringValue
        self.country = data["country"].stringValue
        self.describe = data["describe"].stringValue
        self.resume = data["resume"].stringValue
        self.status = data["status"].stringValue
        self.applyBy = User(data["applyBy"])
        self.job = JobData(data["job"])
        self.postedBy = User(data["postedBy"])
        self.date = data["createdOn"].stringValue
    }
}


