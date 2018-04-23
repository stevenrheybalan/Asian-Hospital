//
//  BillingController.swift
//  Asian Hospital
//
//  Created by HopprLab on 23/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import SCLAlertView

class BillingController: UIViewController {
    
    @IBOutlet weak var chargedAmountLabel: UILabel!
    @IBOutlet weak var depositAmountLabel: UILabel!
    @IBOutlet weak var visitDateLabel: UILabel!
    
    private let client = HopprlabClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        requestBillingInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: METHODS
    
    func requestBillingInformation() {
        guard let userAccount = UserAccount.loadFromKeychain() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again.").setDismissBlock {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        
        let loadingAlertView = Constants.loadingAlertView
        let alertViewResponder: SCLAlertViewResponder = loadingAlertView.showWait("Loading", subTitle: "Please wait while we are preparing your billing information", colorStyle: 0xE67E22)
        
        client.requestBillingInformation(userAccount: userAccount) { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertViewResponder.close()
                
                switch result {
                case .success(let billing):
                    self.chargedAmountLabel.text = "\(billing.chargedAmount ?? 0.00)"
                    self.depositAmountLabel.text = "\(billing.depositAmount ?? 0.00)"
                    self.visitDateLabel.text = "\(billing.visitDate)"
                case .failure(let error):
                    switch error {
                    case .responseUnsuccessful(let statusCode):
                        if statusCode == 409 {
                            SCLAlertView().showInfo("No Open Visit", subTitle: "You don't have current open visit", closeButtonTitle: "OK").setDismissBlock {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }else {
                            fallthrough
                        }
                    default:
                        SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again", closeButtonTitle: "OK").setDismissBlock {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}
