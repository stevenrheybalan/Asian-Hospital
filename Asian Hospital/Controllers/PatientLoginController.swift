//
//  PatientLoginController.swift
//  Asian Hospital
//
//  Created by HopprLab on 02/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import SCLAlertView

class PatientLoginController: UIViewController {
    
    @IBOutlet weak var hospitalNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let client = HopprlabClient()
    private let minimumLength = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func validate(withUsername username: String, password: String) {
        view.endEditing(true)
        
        let loadingAlertView = Constants.loadingAlertView
        let alertViewResponder: SCLAlertViewResponder = loadingAlertView.showWait("Loading", subTitle: "Verifying your credentials", colorStyle: 0xE67E22)
        
        client.validateUser(withUsername: username, password: password) { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertViewResponder.close()
                
                switch result {
                case .success(let userAccount):
                    DispatchQueue.main.async {
                        do {
                            userAccount.password = password
                            try userAccount.save()
                            
                            self.passwordTextField.text = ""
                            
                            self.performSegue(withIdentifier: "showPatientProfile", sender: self)
                        }catch (let error) {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    SCLAlertView().showError("Error", subTitle: "There is something went wrong. Please try again.")
                    
                    print("Failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: ACTIONS
    
    @IBAction func proceedButtonTapped() {
        guard let username = hospitalNumberTextField.text, username.count >= minimumLength else {
            hospitalNumberTextField.shake()
            return
        }

        guard let password = passwordTextField.text, password.count >= minimumLength else {
            passwordTextField.shake()
            return
        }

        validate(withUsername: username, password: password)
    }
    
    @IBAction func noAccountButtonTapped() {
        let title = Constants.dataPrivacyString.title
        let description = Constants.dataPrivacyString.description
        
        SCLAlertView().showInfo(title, subTitle: description, closeButtonTitle: "OK")
    }
}

extension PatientLoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            proceedButtonTapped()
        }
        return true
    }
}

private extension UITextField {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
        self.becomeFirstResponder()
    }
}
