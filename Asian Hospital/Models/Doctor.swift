//
//  Doctor.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Doctor: JSONDecodable {
    let employeeNumber: String
    let displayName: String
    let address: String?
    let department: String?
    
    required init?(json: [String : Any]) {
        struct Key {
            static let employeeNumber = "employee_nr"
            static let displayName = "display_name"
            static let address = "address"
            static let department = "department"
            static let contactNumber = "doc_contacts"
            static let specialization = "doc_specs"
        }
        
        guard let employeeNumber = json[Key.employeeNumber] as? String,
            let displayName = json[Key.displayName] as? String else { return nil }
        
        self.employeeNumber = employeeNumber
        self.displayName = displayName
        self.address = json[Key.address] as? String
        self.department = json[Key.department] as? String
    }
}


