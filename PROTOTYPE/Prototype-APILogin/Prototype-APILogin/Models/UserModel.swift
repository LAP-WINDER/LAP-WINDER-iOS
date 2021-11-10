//
//  UserModel.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/10.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String
}

struct ValidEmail: Codable {
    var email: String
}

typealias TokenAndExpiredDict = Dictionary<String, String>


struct TokenInfo: Codable {
    var accessToken: TokenAndExpiredDict
    var refreshToken: TokenAndExpiredDict
    var provider: String    //kakao, naver
}
