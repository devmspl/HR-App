//
//  GetWishlistModel.swift
//  HRM
//
//  Created by MacBook M1 on 17/06/22.
//

import Foundation
import SwiftyJSON

class GetWishlistModel: NSObject{
    var id: String? = ""
    var userId: String? = ""
    var status: Bool? = false
    var job: JobData? = nil
    convenience init(_ data: JSON) {
        self.init()
        id = data["_id"].stringValue
        userId = data["userId"].stringValue
        status = data["status"].boolValue
        job = JobData(data["jobId"])
    }
}

