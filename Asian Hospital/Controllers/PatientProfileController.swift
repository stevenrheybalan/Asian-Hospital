//
//  PatientProfileController.swift
//  Asian Hospital
//
//  Created by HopprLab on 09/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import SCLAlertView

class PatientProfileController: UITableViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    
    lazy var dataSourceDelegate: PatientProfileDataSourceDelegate = {
        return PatientProfileDataSourceDelegate(viewController: self, tableViewItems: Constants.patientTableViewItems)
    }()
    
    private let client = HopprlabClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate
        
        requestPatientDemographics()
        
        let greetings = Date().greetings
        greetingsLabel.text = "\(greetings), Steven!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sendUserAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func sendUserAction() {
        guard let userAccount = UserAccount.loadFromKeychain() else { return }
        
        let deviceName = UIDevice.current.modelName
        let systemVersion = "iOS \(UIDevice.current.systemVersion)"
        let userAction = UserAction(userId: userAccount.username, deviceName: deviceName, osVersion: systemVersion, action: .login)
        
        client.sendUserAction(userAction) { (result) in
            switch result {
                case .success(_):
                    print("User Action sent!")
                case .failure(let error):
                    print("Send User Action Error: \(error.localizedDescription)")
            }
        }
    }
    
    func requestPatientDemographics() {
        guard let userAccount = UserAccount.loadFromKeychain() else { return }
        
        client.requestPatientInformation(type: .demographics, userAccount: userAccount) { (result) in
            switch result {
                case .success(let json):
//                    print("JSON: \(json)")
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: ACTIONS
    
    @IBAction func logoutButtonTapped() {
        let confirmationAlertView = SCLAlertView()
        confirmationAlertView.addButton("Yes") {
            self.dismiss(animated: true, completion: nil)
        }
        
        confirmationAlertView.showWarning("Logout", subTitle: "Are you sure you want logout?", closeButtonTitle: "No")
    }
}

private extension Date {
    var greetings: String {
        var greeting = ""
        
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: self)
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
        
        return greeting
    }
}
