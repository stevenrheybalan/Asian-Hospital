//
//  ContactController.swift
//  Asian Hospital
//
//  Created by HopprLab on 04/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import SafariServices

class ContactController: UITableViewController {
    
    private lazy var dataSourceDelegate: ContactDataSourceDelegate = {
        return ContactDataSourceDelegate(viewController: self, tableViewItems: Constants.contactTableViewItems)
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
