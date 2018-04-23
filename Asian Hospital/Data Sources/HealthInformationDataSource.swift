//
//  HealthInformationDataSource.swift
//  Asian Hospital
//
//  Created by HopprLab on 18/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class HealthInformationDataSource: NSObject {
    
    private var patientInformation: PatientInformationType
    private let client = HopprlabClient()
 
    init(informationType: PatientInformationType) {
        patientInformation = informationType
        super.init()
    }
    
    // MARK: METHODS
    
    func getPatientData(type: PatientInformationType, completion: @escaping (Result<[JSONDecodable], APIError>) -> Void) {
        guard let userAccount = UserAccount.loadFromKeychain() else { return }
        
        client.requestPatientInformation(type: type, userAccount: userAccount) { (result) in
            switch result {
            case .success(let data):
                switch type {
                case .allergies: break
                case .demographics: break
                case .diagnosis: break
                case .medications: break
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension HealthInformationDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
    }
}
