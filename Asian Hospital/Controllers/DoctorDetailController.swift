//
//  DoctorDetailController.swift
//  Asian Hospital
//
//  Created by HopprLab on 20/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class DoctorDetailController: UITableViewController {

    var doctor: Doctor?
    
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var subSpecialtyLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let doctor = doctor {
            let viewModel = DoctorCellViewModel(doctor: doctor)
            configureView(with: viewModel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func configureView(with viewModel: DoctorCellViewModel) {
        nameLabel.text = viewModel.displayName
        departmentLabel.text = viewModel.department
        specialtyLabel.text = viewModel.specialty
        subSpecialtyLabel.text = viewModel.subSpecialty
        
        addressLabel.text = viewModel.address
        contactNumberLabel.text = viewModel.contactNumber
    }
}
