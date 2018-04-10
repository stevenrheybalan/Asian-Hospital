//
//  PatientProfileDataSourceDelegate.swift
//  Asian Hospital
//
//  Created by HopprLab on 10/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientProfileDataSourceDelegate: NSObject{
    
    var collectionViewItems = [Item]()
    var tableViewItems = [TableViewItem]()
    var storedOffsets = [Int: CGFloat]()
    
    init(tableViewItems: [TableViewItem], collectionViewItems: [Item]) {
        self.tableViewItems = tableViewItems
        self.collectionViewItems = collectionViewItems
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
        return tableViewItems[section].rows
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
            
            horizontalCell.items = collectionViewItems
            horizontalCell.collectionViewOffset = storedOffsets[row] ?? 0
        case 1:
            guard let largeMenuCell = cell as? LargeMenuCell else { return }
            
            largeMenuCell.titleLabel.text = "Health Summary"
            largeMenuCell.subTitleLabel.text = "Apple HealthKit"
            largeMenuCell.iconImageView.image = #imageLiteral(resourceName: "Heart")
            largeMenuCell.button.setTitle("Download", for: .normal)
        case 2:
            guard let largeMenuCell = cell as? LargeMenuCell else { return }
            
            switch indexPath.row {
            case 0:
                largeMenuCell.titleLabel.text = "Patient Barcode"
                largeMenuCell.subTitleLabel.text = "Apple Wallet"
                largeMenuCell.iconImageView.image = #imageLiteral(resourceName: "barcode")
                largeMenuCell.button.setTitle("Generate", for: .normal)
            default: break
            }
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
