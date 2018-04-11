//
//  ContactCollectionViewDelegate.swift
//  Asian Hospital
//
//  Created by HopprLab on 11/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import SafariServices

class ContactCollectionViewDelegate: NSObject {
    
    private var items = [Item]()
    var viewController: UIViewController!
    
    init(viewController: UIViewController, items: [Item]) {
        self.items = items
        self.viewController = viewController
        super.init()
    }

    // MARK: METHODS
    
    private func showWebsite(usingURL url: String) {
        guard let webURL = URL(string: url) else { return }
        
        let safariVC = SFSafariViewController(url: webURL)
        viewController.present(safariVC, animated: true, completion: nil)
    }
}

extension ContactCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let url = items[row].subtitle
        
        showWebsite(usingURL: url)
    }
}
