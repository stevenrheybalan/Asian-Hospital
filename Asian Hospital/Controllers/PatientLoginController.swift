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
    
    // MARK: ACTIONS
    
    @IBAction func proceedButtonTapped() {
        guard let username = hospitalNumberTextField.text, username.count >= 8 else {
            shakeTextField(hospitalNumberTextField)
            return
        }
        
        guard let password = passwordTextField.text, password.count >= 8 else {
            shakeTextField(passwordTextField)
            return
        }
    }
    
    @IBAction func noAccountButtonTapped() {
        
    }
}
