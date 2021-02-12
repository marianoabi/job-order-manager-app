//
//  JobOrder.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import Foundation
import ObjectMapper

class JobOrder: Mappable {
    var referenceID: String?
    var title: String?
    var description: String?
    var clients: [Client]?
    var jobAddress: Address?
    var status: JobStatus?
    
//    var orderNumber: String?
//    var billedClientID: String?
    var priority: Int? = 0
    var jobStatusID: Int? = 0
    var clientID: Int? = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        referenceID <- map["reference"]
        title <- map["title"]
        description <- map["description"]
        clients <- map["clients"]
        jobAddress <- map["address"]
        status <- map["job_status"]
        jobStatusID <- map["job_status_id"]
        clientID <- map["client_id"]
        priority <- map["priority"]
    }
}
