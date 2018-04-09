//
//  HopprlabClient.swift
//  Mod
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class HopprlabClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func requestToken(withUsername username: String, password: String, completion: @escaping (Result<UserAccount, APIError>) -> Void) {
        let grantType = "password"
        let clientId = "COA01"
        let clientSecret = "open@pi01"

        let parameters: Parameters = [
            "grant_type": grantType,
            "username": username,
            "password": password,
            "client_id": clientId,
            "client_secret": clientSecret
        ]

        let endpoint = HopprLab.requestToken
        let request = endpoint.request(with: parameters)

        fetch(with: request, parse: { (json: [String: AnyObject]) -> UserAccount? in
            return UserAccount(json: json)
        }, completion: completion)
    }
    
    func search(withTerm term: String, limit: Int = 10, sortBy sortType: HopprLab.DoctorSortType = .name, completion: @escaping (Result<[Doctor], APIError>) -> Void) {
        let endpoint = HopprLab.searchDoctor(term: term, limit: limit, sortBy: sortType)
        let request = endpoint.request

        fetch(with: request, parse: { (json: [String: AnyObject]) -> [Doctor] in
            guard let doctors = json["data"] as? [[String: Any]] else { return [] }
            return doctors.compactMap { Doctor(json: $0) }
        }, completion: completion)
    }
}
