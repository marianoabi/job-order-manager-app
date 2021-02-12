//
//  JobOrderService.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Moya

enum JobOrderService {
    case getJobOrders
}

extension JobOrderService: BaseService {
    var baseURL: URL {
        return URL(string: CoreService.baseURLString)!
    }
    
    var path: String {
        switch self {
        case .getJobOrders:
            return "/api/v1/job/actual"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getJobOrders:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getJobOrders:
            return .requestPlain
        }
    }
    
    
}
