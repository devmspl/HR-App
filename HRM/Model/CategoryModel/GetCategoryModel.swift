//
//  GetCategoryModel.swift
//  HRM
//
//  Created by MacBook M1 on 17/06/22.
//

import UIKit
import SwiftyJSON

class GetCategoryModel: NSObject {
    var category: String?
    var categoryId: String?
    
    convenience init(_ data: JSON) {
        self.init()
        category = data["category"].stringValue
        categoryId = data["_id"].stringValue
    }
}
