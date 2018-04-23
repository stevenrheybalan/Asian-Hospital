//
//  HealthInformationController.swift
//  Asian Hospital
//
//  Created by HopprLab on 17/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class HealthInformationController: UITableViewController {
    
    var informationType: PatientInformationType!
    
    lazy var dataSource: HealthInformationDataSource = {
       return HealthInformationDataSource(informationType: informationType)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        title = informationType.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
