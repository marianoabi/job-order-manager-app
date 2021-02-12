//
//  UserService.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Moya

enum UserService {
    case login(email: String, password: String)
}

extension UserService: BaseService {
    var baseURL: URL {
        return URL(string: "\(CoreService.baseURLString)")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/oauth/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(
                parameters: [
                    "grant_type": "password",
                    "login": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )        }
    }
}
