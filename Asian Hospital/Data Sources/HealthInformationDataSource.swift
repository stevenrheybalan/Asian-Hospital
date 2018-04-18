//
//  HealthInformationDataSource.swift
//  Asian Hospital
//
//  Created by HopprLab on 18/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class HealthInformationDataSource: NSObject, UITableViewDataSource {
    
    override init() {
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
    }
}
