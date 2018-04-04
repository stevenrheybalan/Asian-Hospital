//
//  DoctorsController.swift
//  Asian Hospital
//
//  Created by HopprLab on 04/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class DoctorsController: UITableViewController {
    
    private let client = HopprlabClient()
    
    private var doctors = [Doctor]() {
        didSet {
            dataSource.update(with: doctors)
            tableView.reloadData()
        }
    }
    
    private lazy var dataSource: DoctorsDataSource = {
        return DoctorsDataSource(doctors: doctors)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        setupNavBar()
        getDoctors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Name, Department, Specialty"
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    func getDoctors() {
        client.search(withTerm: "") { [weak self] result in
            switch result {
            case .success(let doctors):
                self?.doctors = doctors
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
