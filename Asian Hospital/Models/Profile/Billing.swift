//
//  Billing.swift
//  Asian Hospital
//
//  Created by HopprLab on 23/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Billing: JSONDecodable {
    let hospitalNumber: String
    let visitDate: Date
    let depositAmount: Double?
    let chargedAmount: Double?
    
    required init?(json: [String : Any]) {
        struct Key {
            static let hospitalNumber = "hospital_number"
            static let visitDate = "actual_visit_date_time"
            static let depositAmount = "total_deposit"
            static let chargedAmount = "charged_amount"
        }
        
        guard let hospitalNumber = json[Key.hospitalNumber] as? String,
            let visitDateString = json[Key.visitDate] as? String else {
                return nil
        }
        
        self.hospitalNumber = hospitalNumber
        self.depositAmount = json[Key.depositAmount] as? Double
        self.chargedAmount = json[Key.chargedAmount] as? Double
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        guard let visitDate = formatter.date(from: visitDateString) else { return nil }
        
        self.visitDate = visitDate
    }
}
