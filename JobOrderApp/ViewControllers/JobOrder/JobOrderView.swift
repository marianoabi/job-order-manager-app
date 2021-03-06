//
//  JobOrderView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

// MARK: - Protocol
protocol JobOrderViewProtocol {
    func logoutButtonHandler(_ view: JobOrderView)
    func createButtonHandler(_ view: JobOrderView)
}

// MARK: - Properties/Overrides
class JobOrderView: UIView {
    var delegate: JobOrderViewProtocol?
    
    @IBOutlet weak var jobOrderTableView: UITableView!
    
    @IBAction func didTappedLogoutButton(_ sender: UIButton) {
        self.delegate?.logoutButtonHandler(self)
    }
    
    @IBAction func didTappedCreateButton(_ sender: UIButton) {
        self.delegate?.createButtonHandler(self)
    }
    
}
