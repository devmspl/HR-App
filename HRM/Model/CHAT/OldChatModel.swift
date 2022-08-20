//
//  OldChatModel.swift
//  HRM
//
//  Created by MacBook M1 on 06/08/22.
//

import UIKit
import SwiftyJSON

class OldChatModel: NSObject {

    var id: String?
    var msgFrom: String?
    var msgTo: String?
    var msg: String?
    var room: String?
    var date: String?
    
    convenience  init(_ data: JSON) {
        self.init()
        id = data["id"].stringValue
        msgFrom = data["fromMsg"].stringValue
        msgTo = data["toMsg"].stringValue
        msg = data["msg"].stringValue
        room = data["room"].stringValue
        date = data["createdOn"].stringValue
    }
    
}
