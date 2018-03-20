//
//  Doctor.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Doctor: JSONDecodable {
    let employeeNumber: Int
    let displayName: String
    let address: String?
    let department: String?
    let contactNumbers: [ContactNumber]?
    let specializations: [Specialization]?
    
    required init?(json: [String : Any]) {
        struct Key {
            static let employeeNumber = "employee_nr"
            static let displayName = "display_name"
            static let address = "address"
            static let department = "department"
            static let contactNumber = "doc_contacts"
            static let specialization = "doc_specs"
        }
        
        guard let employeeNumber = json[Key.employeeNumber] as? Int,
            let displayName = json[Key.displayName] as? String else { return nil }
        
        self.employeeNumber = employeeNumber
        self.displayName = displayName
        self.address = json[Key.address] as? String
        self.department = json[Key.department] as? String
        
        if let jsonContacts = json[Key.contactNumber] as? [[String: Any]] {
            self.contactNumbers = jsonContacts.flatMap { ContactNumber(json: $0) }
        }else {
            self.contactNumbers = nil
        }

        if let jsonSpecialization = json[Key.specialization] as? [[String: Any]] {
            self.specializations = jsonSpecialization.flatMap { Specialization(json: $0) }
        }else {
            self.specializations = nil
        }
    }
    
    class ContactNumber: JSONDecodable {
        let phoneNumber: String
        
        required init?(json: [String : Any]) {
            struct Key {
                static let phoneNumber = "phone_number"
            }
            
            guard let phoneNumber = json[Key.phoneNumber] as? String else { return nil }
            
            self.phoneNumber = phoneNumber
        }
    }
    
    class Specialization: JSONDecodable {
        let specialty: String
        let subSpecialty: String?
        
        required init?(json: [String : Any]) {
            struct Key {
                static let specialty = "specialty_name"
                static let subSpecialty = "sub_specialty_name"
            }
            
            guard let specialty = json["specialty_name"] as? String else { return nil }
            
            self.specialty = specialty
            self.subSpecialty = json["sub_specialty_name"] as? String
        }
    }
}


