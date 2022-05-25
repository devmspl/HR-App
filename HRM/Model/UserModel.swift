//
//  UserModel.swift
//  HRM
//
//  Created by Macbook Air (ios) on 19/05/22.
//

import Foundation

struct signUpModel: Encodable{
    let userName: String?
    let email: String?
    let companyName: String?
    let password: String?
    let roleType: String?
    let phoneNumber: String?
}

struct loginModel: Encodable{
    let email: String?
    let password: String?
}

struct forgetPassword: Encodable{
    let email: String?
}

struct otpModel: Encodable{
    let otp: String?
}

struct resetPasswordModel: Encodable{
    let newPassword: String?
}

