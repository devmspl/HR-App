//
//  CreateWishlistModel.swift
//  HRM
//
//  Created by MacBook M1 on 17/06/22.
//

import Foundation

struct CreateWishlistModel: Encodable{
    let userId: String?
    let jobId: String?
    let status: Bool?
}
