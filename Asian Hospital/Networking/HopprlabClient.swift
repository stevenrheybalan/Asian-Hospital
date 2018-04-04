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
    
    func search(withTerm term: String, limit: Int = 10, sortBy sortType: HopprLab.DoctorSortType = .name, completion: @escaping (Result<[Doctor], APIError>) -> Void) {
        let endpoint = HopprLab.searchDoctor(term: term, limit: limit, sortBy: sortType)
        let request = endpoint.request

        fetch(with: request, parse: { json -> [Doctor] in
            guard let doctors = json["data"] as? [[String: Any]] else { return [] }
            return doctors.compactMap { Doctor(json: $0) }
        }, completion: completion)
    }
}
