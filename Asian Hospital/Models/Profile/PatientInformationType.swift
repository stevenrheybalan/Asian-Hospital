//
//  PatientInformationType.swift
//  Asian Hospital
//
//  Created by HopprLab on 13/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

enum PatientInformationType: String {
    case demographics = "Demographics"
    case allergies = "Allergies"
    case diagnosis = "Diagnosis"
    case medications = "Medications"
}

extension PatientInformationType {
    var path: String {
        switch self {
            case .demographics: return "GetPatients"
            case .allergies: return "GetPatientAllergies"
            case .diagnosis: return "GetPatientDiagnosis"
            case .medications: return "GetPatientMedications"
        }
    }
}
