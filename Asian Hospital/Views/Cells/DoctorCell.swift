//
//  DoctorCell.swift
//  Asian Hospital
//
//  Created by HopprLab on 20/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {
    
    static let reuseIdentifier = "DoctorCell"
    
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: METHODS
    
    func configure(with viewModel: DoctorCellViewModel) {
        nameLabel.text = viewModel.displayName
        departmentLabel.text = viewModel.department
    }
}
