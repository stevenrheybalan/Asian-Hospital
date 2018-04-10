//
//  PatientProfileController.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientProfileController: UITableViewController {
    
    let collectionViewItems: [Item] = [
        Item(title: "Allergies", subtitle: "", image: #imageLiteral(resourceName: "Allergies")),
        Item(title: "Diagnosis", subtitle: "", image: #imageLiteral(resourceName: "Diagnosis")),
        Item(title: "Medications", subtitle: "", image: #imageLiteral(resourceName: "Medications"))
    ]
    
    let tableViewItems: [TableViewItem] = [
        TableViewItem(title: "Health Information", rows: 1, rowHeight: 160),
        TableViewItem(title: "Summary", rows: 1, rowHeight: 200),
        TableViewItem(title: "Others", rows: 1, rowHeight: 200)
    ]
    
    lazy var dataSourceDelegate: PatientProfileDataSourceDelegate = {
        return PatientProfileDataSourceDelegate(tableViewItems: tableViewItems, collectionViewItems: collectionViewItems)
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
