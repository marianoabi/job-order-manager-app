//
//  BaseErrorResponse.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import ObjectMapper

struct BaseErrorResponse: Mappable {
    
    var errorCode: Int? = 0
    var message: String?
    var statusCode: Int? = 0
    var errorDescription: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        errorCode <- map["error_code"]
        message <- map["message"]
        statusCode <- map["status"]
        errorDescription <- map["error_description"]
    }
}
