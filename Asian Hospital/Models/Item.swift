//
//  Item.swift
//  Asian Hospital
//
//  Created by HopprLab on 03/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

struct Item {
    let title: String
    let subtitle: String
    let image: UIImage?
    let buttonTitle: String?
}

extension Item {
    init(title: String, subtitle: String, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.buttonTitle = nil
    }
}
