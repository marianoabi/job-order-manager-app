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
    
    
    @IBAction func loginButtonHandler(_ sender: UIButton) {
        
        if emailTextField.text == "" {
            print("Email is required.")
            return
        }
        
        if passwordTextField.text == "" {
            print("Password is required.")
            return
        }
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            self.delegate?.loginButtonHandler(self, email: email, password: password)
        }
    }
}
