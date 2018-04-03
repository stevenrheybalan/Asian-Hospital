//
//  HomeMenuCellViewModel.swift
//  Asian Hospital
//
//  Created by HopprLab on 03/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

struct HomeMenuCellViewModel {
    let title: String
    let subtitle: String
    let image: UIImage?
}

extension HomeMenuCellViewModel {
    init(item: Item) {
        title = item.title
        subtitle = item.subtitle
        image = item.image
    }
}
