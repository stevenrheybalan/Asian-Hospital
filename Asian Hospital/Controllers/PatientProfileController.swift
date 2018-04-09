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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 160
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PatientProfileController {
    // MARK: DATA SOURCE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Health Information"
        default: return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalMenuCell", for: indexPath) as! HorizontalMenuCell
        default: break
        }
        
        return cell
    }
    
    // MARK: DELEGATE
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                let cell = cell as! HorizontalMenuCell
            
                cell.items = menuItems

//                let dataSourceDelegate = CollectionViewDataSourceDelegate(withItems: menuItems)
//
//                cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: dataSourceDelegate)
        default: break
        }
    }
}
