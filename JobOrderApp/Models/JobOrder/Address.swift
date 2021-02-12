//
//  Address.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import ObjectMapper

class Address: Mappable {
    var address1: String?
    var city: String?
    var state: String?
    var postCode: String?
    
    var address2: String?
    var country: String?
    var longitude: String?
    var latitude: String?
    var active: Bool? = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        address1 <- map["address1"]
        city <- map["city"]
        state <- map["state"]
        postCode <- map["postcode"]
    }
}
