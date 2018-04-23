//
//  ErrorMessage.swift
//  Asian Hospital
//
//  Created by HopprLab on 20/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class ErrorMessage: JSONDecodable {
    let error: String
    let description: String
    
    required init?(json: [String : Any]) {
        struct Key {
            static let error = "error"
            static let description = "error_description"
        }
        
        guard let error = json[Key.error] as? String, let description = json[Key.description] as? String else { return nil }
        
        self.error = error
        self.description = description
    }
}
