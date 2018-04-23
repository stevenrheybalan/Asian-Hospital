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
    
    static let barcodeSegue = "showBarcode"
    static let billingSegue = "showBillingDetails"
    private let healthInformationSegue = "showHealthInformation"
    
    lazy var dataSourceDelegate: PatientProfileDataSourceDelegate = {
        return PatientProfileDataSourceDelegate(viewController: self, tableViewItems: Constants.patientTableViewItems)
    }()
    
    private let client = HopprlabClient()
    
    var selectedType: PatientInformationType! {
        didSet {
            performSegue(withIdentifier: healthInformationSegue, sender: self)
        }
    }
    
    var demographics: Demographics? {
        didSet {
            let greetings = Date().greetings
            
            if let firstName = demographics?.firstName {
                greetingsLabel.text = "\(greetings), \(firstName)!"
            }else {
                greetingsLabel.text = "\(greetings)!"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate
        
        requestPatientDemographics()
        sendUserLoginAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case healthInformationSegue:
                if let healthInformationVC = segue.destination as? HealthInformationController {
                    healthInformationVC.informationType = selectedType
                }
            case PatientProfileController.barcodeSegue:
                if let barcodeVC = segue.destination as? BarcodeController {
                    barcodeVC.demographics = demographics
                }
        default: break
        }
    }
    
    // MARK: METHODS
    
    func sendUserLoginAction() {
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
        let loadingAlertView = Constants.loadingAlertView
        let alertViewResponder: SCLAlertViewResponder = loadingAlertView.showWait("Loading", subTitle: "Please wait while we are preparing your profile", colorStyle: 0xE67E22)
        
        guard let userAccount = UserAccount.loadFromKeychain() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again.").setDismissBlock {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        
        client.requestPatientInformation(type: .demographics, userAccount: userAccount) { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertViewResponder.close()
                
                switch result {
                case .success(let demographicsArray):
                    guard let demographics = demographicsArray.first as? Demographics else {
                        return
                    }
                    
                    self.demographics = demographics
                case .failure(let error):
                    print(error)
                    SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again.").setDismissBlock {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
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
