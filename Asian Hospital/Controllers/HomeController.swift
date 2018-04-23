//
//  HomeController.swift
//  Asian Hospital
//
//  Created by HopprLab on 03/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    lazy var dataSource: HomeDataSource = {
        return HomeDataSource(items: Constants.homeMenuItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TABLE VIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = Constants.menuIdentifier[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}
