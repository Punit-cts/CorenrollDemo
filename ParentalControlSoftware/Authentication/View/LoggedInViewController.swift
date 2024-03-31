//
//  LoggedInViewController.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 18/12/2023.
//

import UIKit

class LoggedInViewController: UIViewController, OTPVerificationViewModelDelegate {
    
    var otpModel: OTPVerificationViewModel!
    let loginviewcontroller = LoginScreenViewController()
    
    @IBOutlet weak var otpTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.otpModel = OTPVerificationViewModel()
        self.otpModel.delegate = self
        
        self.makeSpinnerforOTP()
    }
    
    @IBAction func verifyOTPButton(_ sender: UIButton) {
        
        self.present(loadingOTPAlert, animated: true)
        
        if let email = self.loginviewcontroller.customTextView?.emailTextField?.text {
            _ = OTPVerificationModel(email: email, user_type: "A", verification_code: self.otpTextField.text!, device_id: self.loginviewcontroller.generateDeviceID())
        }
        else {
            print("Email is nil")
        }

        
    }
    
    let loadingOTPAlert = UIAlertController(title: nil, message: "\n\nVerifying OTP", preferredStyle: .alert)
    
    private func makeSpinnerforOTP() {
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        loadingOTPAlert.view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            
            spinner.centerXAnchor.constraint(equalTo: loadingOTPAlert.view.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: loadingOTPAlert.view.topAnchor, constant: 30),
        ])
        
    }
    
    func didVerifyOTP(){
        
        DispatchQueue.main.async { [weak self] in
            
            self?.loadingOTPAlert.dismiss(animated: true)
            
        }
    }
    
    func OTPVerifyFailed(){
        
        DispatchQueue.main.async {
            
            self.loadingOTPAlert.dismiss(animated: true)
        }
        
        let failureOTPAlert = UIAlertController(title: "Verifying OTP Failed", message: nil, preferredStyle: .alert)
        failureOTPAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        present(failureOTPAlert, animated: true, completion: nil)
    }
}

