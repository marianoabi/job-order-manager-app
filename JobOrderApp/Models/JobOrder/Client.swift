//
//  Client.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import ObjectMapper

struct Client: Mappable {
    var firstName: String?
    var lastName: String?
    var company: String?
    var country: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        company <- map["company_name"]
        country <- map["country"]
    }
}
