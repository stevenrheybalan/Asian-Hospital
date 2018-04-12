//
//  PatientLoginController.swift
//  Asian Hospital
//
//  Created by HopprLab on 02/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit

class PatientLoginController: UIViewController {
    
    @IBOutlet weak var hospitalNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let client = HopprlabClient()
    private let minimumLength = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: METHODS
    
    func shakeTextField(_ textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
        
        textField.becomeFirstResponder()
    }
    
    func validate(withUsername username: String, password: String) {
        client.validateUser(withUsername: username, password: password) { (result) in
            switch result {
            case .success(let userAccount):
                DispatchQueue.main.async {
                    do {
                        try userAccount.save()
                        
                        self.performSegue(withIdentifier: "showPatientProfile", sender: self)
                    }catch (let error) {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: ACTIONS
    
    @IBAction func proceedButtonTapped() {
        guard let username = hospitalNumberTextField.text, username.count >= minimumLength else {
            shakeTextField(hospitalNumberTextField)
            return
        }

        guard let password = passwordTextField.text, password.count >= minimumLength else {
            shakeTextField(passwordTextField)
            return
        }

        validate(withUsername: username, password: password)
    }
    
    @IBAction func noAccountButtonTapped() {
        
    }
}
