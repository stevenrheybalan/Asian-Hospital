//
//  BarcodeController.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import PassKit
import SCLAlertView

class BarcodeController: UIViewController {
    
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    var demographics: Demographics?
    
    private let client = HerokuClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let demographics = demographics else {
            SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again.", closeButtonTitle: "OK").setDismissBlock {
                self.navigationController?.popViewController(animated: true)
            }
            return
        }

        let barcodeImage = generateBarcode(from: demographics.hospitalNumer)
        barcodeImageView.image = barcodeImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ACTIONS
    
    @IBAction func appleWalletButtonTapped() {
        guard let demographics = demographics else { return }
        
        downloadApplePass(using: demographics)
    }
    
    // MARK: METHODS
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    func downloadApplePass(using demographics: Demographics) {
        let loadingAlertView = Constants.loadingAlertView
        let alertViewResponder: SCLAlertViewResponder = loadingAlertView.showWait("Loading", subTitle: "Please wait while we are preparing your Apple Pass", colorStyle: 0xE67E22)
        
        client.requestApplePass(using: demographics) { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertViewResponder.close()
                
                switch result {
                case .success(let data):
                    var error:NSError?
                    let passData = PKPass(data: data, error: &error)
                    
                    guard error == nil else {
                        SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again.")
                        return
                    }
                    
                    let passVC = PKAddPassesViewController(pass: passData)
                    self.present(passVC, animated: true, completion: {})
                case .failure(_):
                    SCLAlertView().showError("Oooops!", subTitle: "There is something went wrong. Please try again.")
                }
            }
        }
    }
}
