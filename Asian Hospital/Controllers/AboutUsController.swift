//
//  AboutUsController.swift
//  Asian Hospital
//
//  Created by HopprLab on 28/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class AboutUsController: UITableViewController {
    
    lazy var dataSource: AboutUsDataSource = {
        return AboutUsDataSource(description: AboutUsData)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        configureTableViewCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func configureTableViewCell() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
    }
}
