//
//  NewJobOrderPopupView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import UIKit

protocol NewJobOrderPopupViewProtocol {
    func createButtonHandler(_ view: NewJobOrderPopupView, jobOrder: JobOrder)
    func closeButtonHandler(_ view: NewJobOrderPopupView)
}

class NewJobOrderPopupView: UIView {
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var delegate: NewJobOrderPopupViewProtocol?
    
    func setupView() {
        self.showErrorMessage(false)
    }
    
    @IBAction func didTappedCreateButton(_ sender: UIButton) {
        
        if self.titleTextField.text?.isEmpty ?? true {
            let message = JobOrderApp.ErrorMessage.titleRequired
            self.showErrorMessage(true, with: message)
            return
        }
        
        if self.descriptionTextView.text?.isEmpty ?? true {
            let message = JobOrderApp.ErrorMessage.descriptionRequired
            self.showErrorMessage(true, with: message)
            return
        }
        
        if let title = self.titleTextField.text, let description = self.descriptionTextView.text {
            self.showErrorMessage(false)
            
            let newJobOrder = JobOrder()
            newJobOrder.title = title
            newJobOrder.description = description
            
            self.delegate?.createButtonHandler(self, jobOrder: newJobOrder )
        }
    }
    
    @IBAction func didTappedCloseButton(_ sender: UIButton) {
        self.delegate?.closeButtonHandler(self)
    }
    
    func showErrorMessage(_ show: Bool, with message: String = "") {
        self.errorMessageLabel.isHidden = !show
        self.errorMessageLabel.text = message
    }
}
