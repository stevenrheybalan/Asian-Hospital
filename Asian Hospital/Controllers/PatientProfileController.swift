//
//  PatientProfileController.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientProfileController: UITableViewController {
    
    let menuItems: [Item] = [
        Item(title: "Allergies", subtitle: "", image: #imageLiteral(resourceName: "Allergies")),
        Item(title: "Diagnosis", subtitle: "", image: #imageLiteral(resourceName: "Diagnosis")),
        Item(title: "Medications", subtitle: "", image: #imageLiteral(resourceName: "Medications"))
    ]
    
    lazy var dataSourceDelegate: PatientProfileDataSourceDelegate = {
        return PatientProfileDataSourceDelegate(collectionViewItems: menuItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate
        
        tableView.rowHeight = 160
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
