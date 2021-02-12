//
//  CarryKeychain.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Foundation
import SwiftKeychainWrapper

// MARK: - Properties
class MyKeychain {
    private static var accessToken = "accessToken"
    private static var refreshToken = "refreshToken"
}

// MARK: - Methods
extension MyKeychain {
    class func storeAccessToken(_ token: String) {
        KeychainWrapper.standard.set(token, forKey: self.accessToken)
    }
    
    class func getAccessToken() -> String? {
        guard let token = KeychainWrapper.standard.string(forKey: self.accessToken) else {
            return nil
        }
        print("AccessToken is \(token)")
        return token
    }
    
    class func removeAccessToken() {
        KeychainWrapper.standard.removeObject(forKey: self.accessToken)
    }
    
    class func storeRefreshToken(_ token: String) {
        KeychainWrapper.standard.set(token, forKey: self.refreshToken)
    }
    
    class func getRefreshToken() -> String? {
        guard let token = KeychainWrapper.standard.string(forKey: self.refreshToken) else {
            return nil
        }
        
        return token
    }
    
    class func removeRefreshToken() {
        KeychainWrapper.standard.removeObject(forKey: self.refreshToken)
    }
    
    class func removeAll() {
        self.removeAccessToken()
        self.removeRefreshToken()
    }
}
