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
    
    var delegate: NewJobOrderPopupViewProtocol?
    
    @IBAction func didTappedCreateButton(_ sender: UIButton) {
        
        if self.titleTextField.text == "" {
            print("Title is required.")
            return
        }
        
        if self.descriptionTextView.text == "" {
            print("Description is required.")
            return
        }
        
        let newJobOrder = JobOrder()
        newJobOrder.title = self.titleTextField.text
        newJobOrder.description = self.descriptionTextView.text
//
        self.delegate?.createButtonHandler(self, jobOrder: newJobOrder )
    }
    
    @IBAction func didTappedCloseButton(_ sender: UIButton) {
        self.delegate?.closeButtonHandler(self)
    }
}
