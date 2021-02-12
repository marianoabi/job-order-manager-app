//
//  JobOrderService.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Moya

enum JobOrderService {
    case getJobOrders
    case createJobOrder(jobOrder: JobOrder)
    case getAllJobStatus
    case getAllClients
}

extension JobOrderService: BaseService {
    var baseURL: URL {
        return URL(string: CoreService.baseURLString)!
    }
    
    var path: String {
        switch self {
        
        case .getJobOrders, .createJobOrder:
            return "/api/v1/job/actual"
            
        case .getAllJobStatus:
            return "/api/v1/job_status"
        case .getAllClients:
            return "/api/v1/client"
        }
    }
    
    var method: Moya.Method {
        switch self {
        
        case .getJobOrders, .getAllJobStatus, .getAllClients:
            return .get
            
        case .createJobOrder:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        
        case .getJobOrders, .getAllJobStatus, .getAllClients:
            return .requestPlain
            
        case let .createJobOrder(jobOrder):
            return .requestParameters(
                parameters: jobOrder.toJSON(),
                encoding: JSONEncoding.default
            )
        }
    }
}
