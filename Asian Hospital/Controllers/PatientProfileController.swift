//
//  PatientProfileController.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientProfileController: UITableViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    
    lazy var dataSourceDelegate: PatientProfileDataSourceDelegate = {
        return PatientProfileDataSourceDelegate(viewController: self, tableViewItems: Constants.patientTableViewItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate
        
        greetingsLabel.text = generateGreetings(usingName: "Steven")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func generateGreetings(usingName name: String) -> String {
        var greeting = ""
        
        let date = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: date)
        let hourInt = Int(currentHour.description)!
        
        if hourInt >= 7 && hourInt <= 12 {
            greeting = "Good morning"
        }else if hourInt >= 12 && hourInt <= 16 {
            greeting = "Good afternoon"
        }else if hourInt >= 16 && hourInt <= 20 {
            greeting = "Good evening"
        }else if hourInt >= 20 && hourInt <= 24 {
            greeting = "Good night"
        }else if hourInt >= 0 && hourInt <= 7 {
            greeting = "You should be sleeping right now"
        }
        
        return "\(greeting), \(name)!"
    }
    
    // MARK: ACTIONS
    
    @IBAction func logoutButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
