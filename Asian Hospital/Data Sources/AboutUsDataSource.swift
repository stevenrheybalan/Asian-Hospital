//
//  AboutUsDataSource.swift
//  Asian Hospital
//
//  Created by HopprLab on 28/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class AboutUsDataSource: NSObject, UITableViewDataSource {

    private var descriptionString: String
    
    init(description: String) {
        self.descriptionString = description
        super.init()
    }
    
    // MARK: TABLE VIEW DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutUsCell.reuseIdentifier, for: indexPath) as! AboutUsCell
        
        cell.configure(withDescription: descriptionString)
        
        return cell
    }
}
