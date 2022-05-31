//
//  JobDetailModel.swift
//  HRM
//
//  Created by Macbook Air (ios) on 30/05/22.
//

import Foundation
import SwiftyJSON

class JobDetailModel: NSObject {
    var id: String?
    var imageUrl: String?
    var jobName: String?
    var salary: Int?
    var location: String?
    
    convenience init(_ data: JSON){
        self.init()
        imageUrl = data["jobType"].stringValue
        jobName = data["title"].stringValue
        salary = data["priceTo"].intValue
        location = data["location"].stringValue
        id = data["_id"].stringValue
    }
    
}


