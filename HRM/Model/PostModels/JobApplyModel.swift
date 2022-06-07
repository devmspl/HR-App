//
//  JobApplyModel.swift
//  HRM
//
//  Created by MacBook M1 on 04/06/22.
//

import Foundation

struct JobApplyModel: Encodable{
    let userId: String?
    let jobId: String?
    let firstName: String?
    let lastname: String?
    let email: String?
    let country: String?
    let describe: String?
    let resume: String?
    let status: String?
}
