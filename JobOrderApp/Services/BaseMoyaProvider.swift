//
//  BaseMoyaProvider.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Foundation
import Moya
import Alamofire

class BaseMoyaProvider<Target> where Target: Moya.TargetType {
    
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [VerbosePlugin(verbose: true)],
         trackInflights: Bool = false) {
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping Completion) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                if error.response?.statusCode == 401 || error.response?.statusCode == 403 {
                    if let token = MyKeychain.getAccessToken(), !token.isEmpty {
                        NotificationCenter.default.post(name: .shouldLogout, object: nil, userInfo: nil)
                    }
                }
                completion(.failure(error))
            }
        }
    }
}
