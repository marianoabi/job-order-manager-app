//
//  JobStatus.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import ObjectMapper

struct JobStatus: Mappable {
    var name: String?
    var colorHex: String?
    var sortOrder: Int = 0
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        colorHex <- map["color_hex"]
        sortOrder <- map["sort_order"]
    }
}
