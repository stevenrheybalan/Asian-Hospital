//
//  Medication.swift
//  Asian Hospital
//
//  Created by HopprLab on 18/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Medication: JSONDecodable {
    let id: String
    let details: String
    let date: Date
    let isActive: Bool
    
    required init?(json: [String : Any]) {
        struct Key {
            static let id = "note_id"
            static let details = "details"
            static let date = "note_date"
            static let isActive = "active_flag"
        }
        
        guard let id = json[Key.id] as? String,
            let details = json[Key.details] as? String,
            let dateString = json[Key.date] as? String,
            let isActive = json[Key.isActive] as? Bool else { return nil }
        
        self.id = id
        self.details = details
        self.isActive = isActive
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        guard let date = formatter.date(from: dateString) else { return nil }
        
        self.date = date
    }
}
