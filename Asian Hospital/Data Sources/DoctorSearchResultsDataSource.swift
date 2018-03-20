//
//  DoctorSearchResultsDataSource.swift
//  Asian Hospital
//
//  Created by HopprLab on 20/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class DoctorSearchResultsDataSource: NSObject, UITableViewDataSource {
    
    private var doctors: [Doctor]
    
    init(doctors: [Doctor]) {
        self.doctors = doctors
        super.init()
    }
    
    // MARK: METHODS
    
    // MARK: DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorCell.reuseIdentifier, for: indexPath) as! DoctorCell
        
        let doctor = doctors[indexPath.row]
        let viewModel = DoctorCellViewModel(doctor: doctor)
        
        cell.configure(with: viewModel)
        
        return cell
    }
}
