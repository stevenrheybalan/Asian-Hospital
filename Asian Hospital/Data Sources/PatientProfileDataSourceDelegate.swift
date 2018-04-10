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
    var storedOffsets = [Int: CGFloat]()
    
    init(collectionViewItems: [Item]) {
        self.collectionViewItems = collectionViewItems
        super.init()
    }
}

extension PatientProfileDataSourceDelegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Health Information"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalMenuCell", for: indexPath) as! HorizontalMenuCell
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
