//
//  CollectionViewDataSourceDelegate.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class CollectionViewDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items = [Item]()
    
    init(withItems items: [Item]) {
        self.items = items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
        let row = indexPath.row
        
        cell.titleLabel.text = items[row].title
        cell.imageView.image = items[row].image
        
        return cell
    }
}
