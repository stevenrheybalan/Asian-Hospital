//
//  AboutUsCell.swift
//  Asian Hospital
//
//  Created by HopprLab on 28/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class AboutUsCell: UITableViewCell {
    
    static let reuseIdentifier = "DescriptionCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: METHODS
    
    func configure(withDescription description: String) {
        descriptionLabel.text = description
    }

}
