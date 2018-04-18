//
//  Demographics.swift
//  Asian Hospital
//
//  Created by HopprLab on 18/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Demographics: JSONDecodable {
    let id: String
    let hospitalNumer: String
    let registrationDate: Date?
    let lastName: String?
    let firstName: String?
    let middleName: String?
    let displayName: String
    let birthdate: Date
    let gender: String?
    let maritalStatus: String?
    let nationality: String?
    let occupation: String?
    
    required init?(json: [String : Any]) {
        struct Key {
            static let id = "patient_id"
            static let hospitalNumber = "hospital_number"
            static let registrationDate = "registration_date"
            static let lastName = "last_name"
            static let firstName = "first_name"
            static let middleName = "middle_name"
            static let displayName = "display_name"
            static let birthdate = "date_of_birth"
            static let gender = "gender"
            static let maritalStatus = "marital_status"
            static let nationality = "nationality"
            static let occupation = "occupation"
        }
        
        guard let id = json[Key.id] as? String,
            let hospitalNumber = json[Key.hospitalNumber] as? String,
            let displayName = json[Key.displayName] as? String,
            let birthdateString = json[Key.birthdate] as? String else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        guard let birthdate = formatter.date(from: birthdateString) else { return nil }
        
        self.id = id
        self.hospitalNumer = hospitalNumber
        self.lastName = json[Key.lastName] as? String
        self.firstName = json[Key.firstName] as? String
        self.middleName = json[Key.middleName] as? String
        self.displayName = displayName
        self.birthdate = birthdate
        self.gender = json[Key.gender] as? String
        self.maritalStatus = json[Key.maritalStatus] as? String
        self.nationality = json[Key.nationality] as? String
        self.occupation = json[Key.occupation] as? String
        
        if let registrationDateString = json[Key.registrationDate] as? String {
            self.registrationDate = formatter.date(from: registrationDateString)
        }else {
            self.registrationDate = nil
        }
    }
    
}
