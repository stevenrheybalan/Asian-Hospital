//
//  JSONDecodable.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    /// Instantiates an instance of the conforming type with a JSON dictionary
    ///
    /// Returns `nil` if the JSON dictionary does not contain all the values
    /// needed for instantiation of the conforming type
    init?(json: [String: Any])
}
