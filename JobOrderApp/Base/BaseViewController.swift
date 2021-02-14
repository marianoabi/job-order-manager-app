//
//  BaseViewController.swift
//  Sample
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit
import MBProgressHUD

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
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -100
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
    deinit {
        print("Deallocated - \(self)")
        self.removeKeyboardObservers()
    }
}

// MARK: - Navigation Functions
extension BaseViewController {
    func goToNewJobOrderPopup(_ viewController: UIViewController, delegate: NewJobOrderPopupViewControllerProtocol) {
        if let viewController = UIStoryboard(name: JobOrderApp.Storyboard.jobOrder, bundle: nil).instantiateViewController(withIdentifier: JobOrderApp.ViewController.newJobOrderPopupViewController) as? NewJobOrderPopupViewController {
            viewController.delegate = delegate
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
}

// MARK: - MBProgressHUD
extension BaseViewController {
    func showLoadingProgress() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoadingProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
