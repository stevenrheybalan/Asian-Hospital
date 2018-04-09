//
//  Token.swift
//  Asian Hospital
//
//  Created by HopprLab on 06/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation
import KeychainSwift

class UserAccount: NSObject, JSONDecodable {
    let username: String
    let accessToken: String
    let expirationPeriod: TimeInterval
//    let grantDate: Date
    
    static let service = "HopprLab"
    
    struct Key {
        static let username = "username"
        static let accessToken = "access_token"
        static let expirationPeriod = "expires_in"
        static let grantDate = ".issued"
    }
    
    required init?(json: [String : Any]) {
        guard let username = json[Key.username] as? String,
            let token = json[Key.accessToken] as? String,
            let expiration = json[Key.expirationPeriod] as? TimeInterval else { return nil }
        
        self.username = username
        self.accessToken = token
        self.expirationPeriod = expiration
//        self.grantDate = grantDate
    }
    
    func save() throws {
        let dataDictionary: [String: Any] = [
            Key.username: username,
            Key.accessToken: accessToken,
            Key.expirationPeriod: expirationPeriod,
//            Key.grantDate: grantDate
        ]
        
        let data = try PropertyListSerialization.data(fromPropertyList: dataDictionary, format: .binary, options: 0)
        let keychain = KeychainSwift()
        
        keychain.set(data, forKey: UserAccount.service)
    }
    
    static func loadFromKeychain() -> UserAccount? {
        let keychain = KeychainSwift()
        
        guard let data = keychain.getData(UserAccount.service),
            let dictionary = try! PropertyListSerialization.propertyList(from: data, format: nil) as? Dictionary<String, Any> else { return nil }
        
        return UserAccount(json: dictionary)
    }
}
