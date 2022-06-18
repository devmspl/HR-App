//
//  GetProfileModel.swift
//  HRM
//
//  Created by MacBook M1 on 04/06/22.
//

import UIKit
import SwiftyJSON

class GetProfileModel: NSObject {
    var name: String? = ""
    var email: String? = ""
    var type: String? = ""
    var number: String? = ""
    var imageUrl: String? = ""
    
    convenience init(_ data: JSON) {
        self.init()
        imageUrl = data["image"].stringValue
        name = data["userName"].stringValue
        email = data["email"].stringValue
        type = data["roleType"].stringValue
        number = data["phoneNumber"].stringValue

    }
}
