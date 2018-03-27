//
//  ContactController.swift
//  Asian Hospital
//
//  Created by HopprLab on 27/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class ContactController: UITableViewController {

    lazy var contacts: [Contact] = {
        guard let contactsJSON = contactData["contacts"] as? [[String: Any]] else { return [] }
        let contacts = contactsJSON.flatMap { Contact(json: $0) }
        return contacts
    }()
    
    lazy var dataSource: ContactDataSource = {
        return ContactDataSource(contacts: self.contacts)
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        if let url = contact.url {
            UIApplication.shared.openURL(url)
        }else {
            // TODO: Show unable to call alert
            print("Unable to call")
        }
    }
}
