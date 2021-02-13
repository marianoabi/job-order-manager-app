//
//  BaseViewController.swift
//  Sample
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

class BaseViewController: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibNamed(_ nibName: String) {
        if let nibs: Array = Bundle.main.loadNibNamed(nibName, owner: self, options: nil) {
            self.view = nibs.first as? UIView
        } else {
            print("Xib named \(nibName) not found.")
        }
    }
    
    deinit {
        print("Deallocated - \(self)")
    }
}

// MARK: - Navigation Functions
extension BaseViewController {
    func goToNewJobOrderPopup(_ viewController: UIViewController) {
        if let viewController = UIStoryboard(name: "JobOrder", bundle: nil).instantiateViewController(withIdentifier: "NewJobOrderPopupViewController") as? NewJobOrderPopupViewController {
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
}
