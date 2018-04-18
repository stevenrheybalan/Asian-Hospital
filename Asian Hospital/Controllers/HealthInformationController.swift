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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = informationType.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
