//
//  StubHopprLabClient.swift
//  Asian Hospital
//
//  Created by HopprLab on 16/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class StubHopprlabClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    private func getJSON(fromResource name: String) -> Result<JSON, APIError> {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else { return Result.failure(.invalidData) }
        
        do {
            let data = try Data(contentsOf: url)
            if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                return Result.success(json)
            }else {
                return Result.failure(.jsonParsingFailure)
            }
        }catch {
            return Result.failure(.jsonParsingFailure)
        }
    }
    
    private func requestToken(withUsername username: String, password: String, completion: @escaping (Result<UserAccount, APIError>) -> Void) {
        let result = getJSON(fromResource: "StubToken")
        
        switch result {
            case .success(let json):
                if let userAccount = UserAccount(json: json) {
                    completion(Result.success(userAccount))
                }else {
                    completion(Result.failure(.invalidData))
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
    }

    func validateUser(withUsername username: String, password: String, completion: @escaping (Result<UserAccount, APIError>) -> Void) {
        requestToken(withUsername: "", password: "") { (result) in
            switch result {
            case .success(let userAccount):
                completion(Result.success(userAccount))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendUserAction(_ userAction: UserAction, completion: @escaping (Result<Bool, APIError>) -> Void) {
        
    }
    
    func requestPatientInformation(type: PatientInformationType, userAccount: UserAccount, completion: @escaping (Result<[JSONDecodable], APIError>) -> Void) {
        
    }
    
    func search(withTerm term: String, limit: Int = 10, sortBy sortType: HopprLab.DoctorSortType = .name, completion: @escaping (Result<[Doctor], APIError>) -> Void) {
        
    }
}
