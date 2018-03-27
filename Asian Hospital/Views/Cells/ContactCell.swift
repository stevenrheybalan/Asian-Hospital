//
//  ContactCell.swift
//  Asian Hospital
//
//  Created by HopprLab on 27/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    static let reuseIdentifier = "ContactCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: METHODS
    
    func configure(with viewModel: ContactCellViewModel) {
        nameLabel.text = viewModel.name
        numberLabel.text = viewModel.number
    }
}
