//
//  MenuCollectionViewCell.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "MenuCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell() {
        clipsToBounds = true
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
