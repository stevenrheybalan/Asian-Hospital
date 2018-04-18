//
//  Diagnosis.swift
//  Asian Hospital
//
//  Created by HopprLab on 18/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Diagnosis: JSONDecodable {
    let visitId: String
    let visitDate: Date
    let visitType: String
    let chargeType: String
    let codingType: String
    let codingSystem: String
    let code: String
    let diagnosis: String
    let recordedDate: Date
    let isActive: Bool
    let isPrimary: Bool
    let isVisitDiagnostic: Bool
    
    required init?(json: [String : Any]) {
        struct Key {
            static let visitId = "patient_visit_id"
            static let visitDate = "patient_visit_date_time"
            static let visitType = "visit_type"
            static let chargeType = "charge_type"
            static let codingType = "coding_type"
            static let codingSystem = "coding_system"
            static let code = "code"
            static let diagnosis = "diagnosis"
            static let recordedDate = "recorded_date_time"
            static let isActive = "active_flag"
            static let isPrimary = "primary_flag"
            static let isVisitDiagnostic = "current_visit_diagnostic_flag"
        }
        
        guard let visitId = json[Key.visitId] as? String,
            let visitDateString = json[Key.visitDate] as? String,
            let visitType = json[Key.visitType] as? String,
            let chargeType = json[Key.chargeType] as? String,
            let codingType = json[Key.codingType] as? String,
            let codingSystem = json[Key.codingSystem] as? String,
            let code = json[Key.code] as? String,
            let diagnosis = json[Key.diagnosis] as? String,
            let recordedDateString = json[Key.recordedDate] as? String,
            let isActive = json[Key.isActive] as? Bool,
            let isPrimary = json[Key.isPrimary] as? Bool,
            let isVisitDiagnostic = json[Key.isVisitDiagnostic] as? Bool else { return nil }
        
        self.visitId = visitId
        self.visitType = visitType
        self.chargeType = chargeType
        self.codingType = codingType
        self.codingSystem = codingSystem
        self.code = code
        self.diagnosis = diagnosis
        self.isActive = isActive
        self.isPrimary = isPrimary
        self.isVisitDiagnostic = isVisitDiagnostic
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        guard let visitDate = formatter.date(from: visitDateString),
            let recordedDate = formatter.date(from: recordedDateString) else { return nil }
        
        self.visitDate = visitDate
        self.recordedDate = recordedDate
    }
}
