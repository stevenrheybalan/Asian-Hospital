//
//  DoctorController.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class DoctorController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let client = HopprlabClient()
    
    var doctors: [Doctor]? {
        didSet {
            self.performSegue(withIdentifier: "showDoctorSearchResults", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDoctorSearchResults" {
            if let searchResultsController = segue.destination as? DoctorSearchResultsController {
                searchResultsController.doctors = self.doctors
            }
        }
    }
    
    // MARK: METHODS
    
    // MARK: ACTIONS
    
    @IBAction func findDoctorButtonTapped() {
        guard let searchText = searchTextField.text, searchText != "" else { return }
        
        client.search(withTerm: searchText) { [weak self] result in
            switch result {
            case .success(let doctors):
                self?.doctors = doctors
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
