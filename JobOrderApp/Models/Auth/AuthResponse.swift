//
//  AuthResponse.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import ObjectMapper

struct AuthResponse: Mappable {
    var accessToken: String?
    var tokenType: String?
    var expiresIn: Int? = 0
    var refreshToken: String?
    var createdAt: Int? = 0
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["tokenType"]
        expiresIn <- map["expires_in"]
        refreshToken <- map["refresh_token"]
        createdAt <- map["created_at"]
    }
}
