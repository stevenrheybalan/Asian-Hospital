//
//  HerokuClient.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class HerokuClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func requestApplePass(using demographics: Demographics, completion: @escaping (Result<Data, APIError>) -> Void) {
        let hospitalNumber = demographics.hospitalNumer
        let patientName = demographics.displayName
        let gender = demographics.gender ?? "No Data"
        
        let parameters: Parameters = [
            "hospital_number": hospitalNumber,
            "patient_name": patientName,
            "gender": gender
        ]
        
        let endpoint = Heroku.requestApplePass
        let request = endpoint.request(with: parameters)
        
        fetchData(with: request, completion: completion)
    }
}
