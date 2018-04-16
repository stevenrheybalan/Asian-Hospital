//
//  UserAction.swift
//  Asian Hospital
//
//  Created by HopprLab on 12/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

struct UserAction {
    let applicationId: Int = 1
    let userId: String
    let deviceName: String
    let osVersion: String
    let location: String?
    let action: Action
}

extension UserAction {
    init(userId: String, deviceName: String, osVersion: String, location: String = "", action: Action) {
        self.userId = userId
        self.deviceName = deviceName
        self.osVersion = osVersion
        self.location = location
        self.action = action
    }
}

enum Action: String {
    case login = "Login"
}
