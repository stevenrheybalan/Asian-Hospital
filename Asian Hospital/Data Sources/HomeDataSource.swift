//
//  HomeDataSource.swift
//  Asian Hospital
//
//  Created by HopprLab on 03/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
    private var items: [Item]
    
    init(items: [Item]) {
        self.items = items
        super.init()
    }
    
    // MARK: TABLE VIEW DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeMenuCell.reuseIdentifier, for: indexPath) as! HomeMenuCell
        
        let item = items[indexPath.row]
        let viewModel = HomeMenuCellViewModel(item: item)
        
        cell.configure(with: viewModel)
        
        return cell
    }
}
