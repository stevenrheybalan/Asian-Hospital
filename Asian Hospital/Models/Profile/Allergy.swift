//
//  Allergies.swift
//  Asian Hospital
//
//  Created by HopprLab on 18/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Allergy: JSONDecodable {
    
    let hospitalNumber: String
    let cause: String
    let reaction: String?
    let status: AllergyStatus
    
    required init?(json: [String : Any]) {
        struct Key {
            static let hospitalNumber = "hospital_number"
            static let cause = "cause"
            static let reaction = "reaction"
            static let status = "reaction_cause_status"
        }
        
        guard let hospitalNumber = json[Key.hospitalNumber] as? String,
            let cause = json[Key.cause] as? String,
            let statusString = json[Key.status] as? String else { return nil }
        
        self.hospitalNumber = hospitalNumber
        self.cause = cause
        self.reaction = json[Key.reaction] as? String
        
        if let status = AllergyStatus(rawValue: statusString) {
            self.status = status
        }else {
            self.status = .inactive
        }
    }
}

enum AllergyStatus: String {
    case active = "Active"
    case inactive = "Inactive"
}
