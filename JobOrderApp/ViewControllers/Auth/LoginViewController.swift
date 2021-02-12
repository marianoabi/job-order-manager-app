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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Methods
extension LoginViewController {
    private func setupViews() {
        self.contentView?.delegate = self
        
        MyKeychain.removeAll()
    }
}

// MARK: - LoginViewView
extension LoginViewController: LoginViewView {
    func loginButtonHandler(_ view: LoginView, email: String, password: String) {
        print("Did Tapped Login Button *****")
        
        self.presenter.login(email: email, password: password)
    }
}

// MARK: - LoginViewPresenter
extension LoginViewController: LoginViewPresenterView {
    func successLogin(_ presenter: LoginViewPresenter) {
        print("Success login.....")
        NotificationCenter.default.post(name: .shouldGoToHomepage, object: nil)
    }
    
    func failLogin(_ presenter: LoginViewPresenter) {
        print("Failed to login.....")
    }
}
