//
//  JobOrder.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import Foundation
import ObjectMapper

struct JobOrder: Mappable {
    var referenceID: String?
    var title: String?
    var description: String?
    var clients: [Client]?
    var jobAddress: Address?
    var status: JobStatus?

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        referenceID <- map["reference"]
        title <- map["title"]
        description <- map["description"]
        clients <- map["clients"]
        jobAddress <- map["address"]
        status <- map["job_status"]
    }
}
