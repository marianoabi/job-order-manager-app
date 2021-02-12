//
//  LoginViewPresenter.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Foundation
import Moya_ObjectMapper

protocol LoginViewPresenterView: BasePresenterView {
    func successLogin(_ presenter: LoginViewPresenter)
    func failLogin(_ presenter: LoginViewPresenter)
}

// MARK: - Properties/Overrides
class LoginViewPresenter {
    var view: LoginViewPresenterView?
    var userProvider: BaseMoyaProvider<UserService>?
    
    init(_ view: LoginViewPresenterView, userProvider: BaseMoyaProvider<UserService>) {
        self.view = view
        self.userProvider = userProvider
    }
}

// MARK: - Functions
extension LoginViewPresenter {
    func login(email: String, password: String) {
        self.userProvider?.request(.login(email: email, password: password), completion: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let authResponse = try? response.mapObject(AuthResponse.self)
                if let aToken = authResponse?.accessToken, let rToken = authResponse?.refreshToken {
                    print("Access token is \(aToken), refresh token is \(rToken)")
                    
                    MyKeychain.storeAccessToken(aToken)
                    MyKeychain.storeRefreshToken(rToken)
                    
                    self.view?.successLogin(self)
                    self.view?.onLoadingEnd?()
                } else {
                    print("No token found.....")
                }
                
            case let .failure(error):
                self.view?.onLoadingEnd?()
                self.view?.onError?(error: error.errorDescription ?? "An error ocurred.")
                self.view?.failLogin(self)
            }
        })
    }
}
