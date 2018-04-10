//
//  PatientProfileController.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientProfileController: UITableViewController {
    
    let tableViewItems: [TableViewItem] = [
        TableViewItem(title: "Health Information", rowHeight: 165, items: [
            Item(title: "Demographics", subtitle: "", image: #imageLiteral(resourceName: "Profile")),
            Item(title: "Allergies", subtitle: "", image: #imageLiteral(resourceName: "Allergies")),
            Item(title: "Diagnosis", subtitle: "", image: #imageLiteral(resourceName: "Diagnosis")),
            Item(title: "Medications", subtitle: "", image: #imageLiteral(resourceName: "Medications"))]),
        TableViewItem(title: "Summary", rowHeight: 200, items: [
            Item(title: "Health Record Summary", subtitle: "Apple HealthKit", image: #imageLiteral(resourceName: "Heart"), buttonTitle: "Download")]),
        TableViewItem(title: "Others", rowHeight: 200, items: [
            Item(title: "Patient Barcode", subtitle: "Apple Wallet", image: #imageLiteral(resourceName: "Barcode"), buttonTitle: "Generate"),
            Item(title: "Billing Details", subtitle: "Inpatient Only", image: #imageLiteral(resourceName: "Bill"), buttonTitle: "Generate")])
    ]
    
    lazy var dataSourceDelegate: PatientProfileDataSourceDelegate = {
        return PatientProfileDataSourceDelegate(tableViewItems: tableViewItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
