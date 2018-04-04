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
    
    private var filteredDoctors = [Doctor]() {
        didSet {
            if isFiltering() {
                dataSource.update(with: filteredDoctors)
            }else {
                dataSource.update(with: doctors)
            }
            
            tableView.reloadData()
        }
    }
    
    private lazy var dataSource: DoctorsDataSource = {
        return DoctorsDataSource(doctors: doctors)
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Name, Department"
        
        definesPresentationContext = true
        
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
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension DoctorsController: UISearchResultsUpdating {
    // MARK: SEARCH RESULTS UPDATING DELEGATE
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDoctors = doctors.filter({ (doctor: Doctor) -> Bool in
            return doctor.displayName.lowercased().contains(searchText.lowercased()) ||
                    doctor.department?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        tableView.reloadData()
    }
}
