//
//  Contact.swift
//  Asian Hospital
//
//  Created by HopprLab on 27/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

class Contact: JSONDecodable {
    let name: String
    let number: String
    
    required init?(json: [String : Any]) {
        struct Key {
            static let name = "contact_name"
            static let number = "contact_number"
        }
        
        guard let name = json[Key.name] as? String, let number = json[Key.number] as? String else { return nil }
        
        self.name = name
        self.number = number
    }
}
