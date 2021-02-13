//
//  LoginView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

protocol LoginViewView {
    func loginButtonHandler(_ view: LoginView, email: String, password: String)
}

class LoginView: UIView {
    var delegate: LoginViewView?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    func setupView() {
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        
        self.emailTextField.becomeFirstResponder()
        self.errorMessageLabel.isHidden = true
    }
    
    @IBAction func loginButtonHandler(_ sender: UIButton) {
        
        if emailTextField.text?.isEmpty ?? true {
            let message = JobOrderApp.ErrorMessage.emailRequired
            self.showErrorMessage(true, with: message)
            return
        }
        
        if passwordTextField.text?.isEmpty ?? true {
            let message = JobOrderApp.ErrorMessage.passwordRequired
            self.showErrorMessage(true, with: message)
            return
        }
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            self.showErrorMessage(false)
            self.delegate?.loginButtonHandler(self, email: email, password: password)
        }
    }
    
    func showErrorMessage(_ show: Bool, with message: String = "") {
        self.errorMessageLabel.isHidden = !show
        self.errorMessageLabel.text = message
    }
}
