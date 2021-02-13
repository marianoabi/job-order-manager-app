//
//  LoginViewController.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

// MARK: - Properties/Overrides
class LoginViewController: BaseViewController {
    private var contentView: LoginView?
    private var userProvider = BaseMoyaProvider<UserService>()
    private lazy var presenter = LoginViewPresenter(self, userProvider: userProvider)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        super.loadNibNamed("LoginView")
        self.contentView = self.view as? LoginView
    }
}

// MARK: - Lifecycle
extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.addKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObservers()
    }
}

// MARK: - Methods
extension LoginViewController {
    private func setupViews() {
        self.contentView?.emailTextField.delegate = self
        self.contentView?.passwordTextField.delegate = self
        
        self.contentView?.setupView()
        self.contentView?.delegate = self
    }
}

// MARK: - LoginViewView
extension LoginViewController: LoginViewView {
    func loginButtonHandler(_ view: LoginView, email: String, password: String) {
        self.presenter.login(email: email, password: password)
    }
}

// MARK: - LoginViewPresenter
extension LoginViewController: LoginViewPresenterView {
    func successLogin(_ presenter: LoginViewPresenter) {
        NotificationCenter.default.post(name: .shouldGoToHomepage, object: nil)
    }
    
    func onLoadingStart() {
        self.showLoadingProgress()
    }
    
    func onLoadingEnd() {
        self.hideLoadingProgress()
    }
    
    func onError(error: String) {
        self.contentView?.showErrorMessage(true, with: error)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.contentView?.emailTextField {
            self.contentView?.passwordTextField.becomeFirstResponder()
        }
        return true
    }
}
