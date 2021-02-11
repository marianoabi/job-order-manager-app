//
//  LoginViewController.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

// MARK: - Properties/Overrides
class LoginViewController: BaseViewController {
    var contentView: LoginView?
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
