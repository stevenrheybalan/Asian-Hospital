//
//  DoctorSearchResultsController.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class DoctorSearchResultsController: UITableViewController {
    
    var doctors: [Doctor]!
    
    lazy var dataSource = {
        return DoctorSearchResultsDataSource(doctors: doctors)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDoctorDetails" {
            if let doctorDetailController = segue.destination as? DoctorDetailController,
                let indexPath = tableView.indexPathForSelectedRow {
                
                let doctor = doctors[indexPath.row]
                doctorDetailController.doctor = doctor
            }
        }
    }
    
    // MARK: TABLE VIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}