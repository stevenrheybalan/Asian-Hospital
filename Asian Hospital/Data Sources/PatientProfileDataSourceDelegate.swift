//
//  PatientProfileDataSourceDelegate.swift
//  Asian Hospital
//
//  Created by HopprLab on 10/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientProfileDataSourceDelegate: NSObject{
    
    private var tableViewItems = [TableViewItem]()
    private var storedOffsets = [Int: CGFloat]()
    
    init(tableViewItems: [TableViewItem]) {
        self.tableViewItems = tableViewItems
        super.init()
    }
}

extension PatientProfileDataSourceDelegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewItems[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems[section].hasCollectionView ? 1 : tableViewItems[section].items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewItems[indexPath.section].rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: HorizontalMenuCell.reuseIdentifier, for: indexPath) as! HorizontalMenuCell
        case 1, 2:
            cell = tableView.dequeueReusableCell(withIdentifier: LargeMenuCell.reuseIdentifier, for: indexPath) as! LargeMenuCell
        default: break
        }
        
        return cell
    }
}

extension PatientProfileDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let horizontalCell = cell as? HorizontalMenuCell else { return }
            let row = indexPath.row
            
            // TODO: Set data source and delegate
            
//            horizontalCell.items = tableViewItems[indexPath.section].items
            horizontalCell.collectionViewOffset = storedOffsets[row] ?? 0
        case 1, 2:
            guard let largeMenuCell = cell as? LargeMenuCell else { return }
            let item = tableViewItems[indexPath.section].items[indexPath.row]
            
            largeMenuCell.titleLabel.text = item.title
            largeMenuCell.subTitleLabel.text = item.subtitle
            largeMenuCell.iconImageView.image = item.image
            largeMenuCell.button.setTitle(item.buttonTitle ?? "", for: .normal)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let horizontalCell = cell as? HorizontalMenuCell else { return }
            let row = indexPath.row
            
            storedOffsets[row] = horizontalCell.collectionViewOffset
        default: break
        }
    }
}
