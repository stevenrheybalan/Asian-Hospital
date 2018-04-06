//
//  PatientAccount.swift
//  Asian Hospital
//
//  Created by HopprLab on 06/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation
import KeychainSwift

struct PatientAccount {
    let username: String
    let accessToken: String
    let expirationPeriod: TimeInterval
    let grantDate: Date
    
    static let service = "HopprLab"
}

extension PatientAccount {
    struct Key {
        static let username = "username"
        static let accessToken = "access_token"
        static let expirationPeriod = "expires_in"
        static let grantDate = ".issued"
    }
    
    func save() throws {
        let dataDictionary: [String: Any] = [
            Key.username: username,
            Key.accessToken: accessToken,
            Key.expirationPeriod: expirationPeriod,
            Key.grantDate: grantDate
        ]
        
        let data = try PropertyListSerialization.data(fromPropertyList: dataDictionary, format: .binary, options: 0)
        let keychain = KeychainSwift()
        
        keychain.set(data, forKey: PatientAccount.service)
    }
    
    static func loadFromKeychain() -> PatientAccount? {
        let keychain = KeychainSwift()
        
        guard let data = keychain.getData(PatientAccount.service),
        let dictionary = try! PropertyListSerialization.propertyList(from: data, format: nil) as? Dictionary<String, Any> else { return nil }
        
        guard let patientUsername = dictionary[Key.username] as? String,
            let token = dictionary[Key.accessToken] as? String,
            let expiration = dictionary[Key.expirationPeriod] as? TimeInterval,
            let grantDateValue = dictionary[Key.grantDate] as? Date else { return nil }

        return PatientAccount(username: patientUsername, accessToken: token, expirationPeriod: expiration, grantDate: grantDateValue)
    }
}
