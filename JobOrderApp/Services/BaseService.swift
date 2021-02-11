//
//  BaseService.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Moya

protocol BaseService: TargetType {}

extension BaseService {
    
    var headers: [String : String]? {
        guard let accessToken = MyKeychain.getAccessToken() else {
            return ["Content-type": "application/json"]
        }
        
        return [
            "Content-type": "application/json",
            "Authorization": accessToken
        ]
    }
    
}
