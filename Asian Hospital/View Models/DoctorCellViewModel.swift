//
//  DoctorCellViewModel.swift
//  Asian Hospital
//
//  Created by HopprLab on 20/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

struct DoctorCellViewModel {
    let employeeNumber: String
    let displayName: String
    let address: String
    let department: String
}

extension DoctorCellViewModel {
    init(doctor: Doctor) {
        self.employeeNumber = String(doctor.employeeNumber)
        self.displayName = doctor.displayName
        self.address = doctor.address ?? "No address"
        self.department = doctor.department ?? "No department"
    }
}
