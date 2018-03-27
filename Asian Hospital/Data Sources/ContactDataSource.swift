//
//  ContactDataSource.swift
//  Asian Hospital
//
//  Created by HopprLab on 27/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class ContactDataSource: NSObject, UITableViewDataSource {

    private var contacts: [Contact]
    
    init(contacts: [Contact]) {
        self.contacts = contacts
        super.init()
    }
    
    // MARK: METHODS
    
    // MARK: DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as! ContactCell
        
        let contact = contacts[indexPath.row]
        let viewModel = ContactCellViewModel(contact: contact)
        
        cell.configure(with: viewModel)
        
        return cell
    }
}
