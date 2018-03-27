//
//  ContactCellViewModel.swift
//  Asian Hospital
//
//  Created by HopprLab on 27/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

struct ContactCellViewModel {
    let name: String
    let number: String
}

extension ContactCellViewModel {
    init(contact: Contact) {
        name = contact.name
        number = contact.number
    }
}
