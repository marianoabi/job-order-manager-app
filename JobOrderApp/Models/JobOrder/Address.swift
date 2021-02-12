//
//  Address.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import ObjectMapper

struct Address: Mappable {
    var address: String?
    var city: String?
    var state: String?
    var postCode: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        address <- map["address1"]
        city <- map["city"]
        state <- map["state"]
        postCode <- map["postcode"]
    }
}
