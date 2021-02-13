//
//  LoginViewPresenter.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Foundation
import Moya_ObjectMapper
import Moya

protocol LoginViewPresenterView: BasePresenterView {
    func successLogin(_ presenter: LoginViewPresenter)
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
        self.view?.onLoadingStart?()
        self.userProvider?.request(.login(email: email, password: password), completion: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.view?.onLoadingEnd?()
                
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let authResponse = try response.mapObject(AuthResponse.self)
                    
                    if let aToken = authResponse.accessToken, let rToken = authResponse.refreshToken {
                        
                        //Store token
                        MyKeychain.storeAccessToken(aToken)
                        MyKeychain.storeRefreshToken(rToken)
                        
                        self.view?.successLogin(self)
                        
                    } else {
                        
                        self.view?.onError?(error: JobOrderApp.ErrorMessage.byDefault)
                    }
                    
                } catch(let error) {
                    
                    if let error = error as? MoyaError {
                        do {
                            if let data = try error.response?.mapObject(BaseErrorResponse.self) {
                                
                                if let description = data.errorDescription {
                                    self.view?.onError?(error: description)

                                } else if let message = data.message {
                                    self.view?.onError?(error: message)

                                } else {
                                    self.view?.onError?(error: data.message ?? JobOrderApp.ErrorMessage.byDefault)
                                }
                            }
                        } catch {
                            
                            self.view?.onError?(error: JobOrderApp.ErrorMessage.byDefault)
                            
                        }
                        
                    } else {
                        
                        self.view?.onError?(error: JobOrderApp.ErrorMessage.byDefault)
                    }
                }
                
            case let .failure(error):
                self.view?.onLoadingEnd?()
                self.view?.onError?(error: error.errorDescription ?? JobOrderApp.ErrorMessage.byDefault)
            }
        })
    }
}
