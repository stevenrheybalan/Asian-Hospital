//
//  DoctorCellViewModel.swift
//  Asian Hospital
//
//  Created by HopprLab on 20/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

struct DoctorCellViewModel {
    let displayName: String
    let address: String
    let department: String
    let specialty: String
    let subSpecialty: String
    let contactNumber: String
}

extension DoctorCellViewModel {
    init(doctor: Doctor) {
        displayName = doctor.displayName
        address = doctor.address ?? "No data"
        department = doctor.department ?? "No data"
        
        if let specializations = doctor.specializations, let specialization = specializations.first {
            specialty = specialization.specialty
            subSpecialty = specialization.subSpecialty ?? "No data"
        }else {
            specialty = "No data"
            subSpecialty = "No data"
        }
        
        if let contactNumbers = doctor.contactNumbers, contactNumbers.count > 0 {
            var combinedContactNumbers: String?
            
            for contactNumber in contactNumbers {
                if let unwrappedCombinedContactNumbers = combinedContactNumbers {
                    combinedContactNumbers = "\(unwrappedCombinedContactNumbers) • \(contactNumber.phoneNumber)"
                }else {
                    combinedContactNumbers = contactNumber.phoneNumber
                }
            }
            
            contactNumber = combinedContactNumbers ?? "No data"
        }else {
            contactNumber = "No data"
        }
    }
}
