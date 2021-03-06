//
//  NewJobOrderPopupViewController.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import UIKit

// MARK: - Protocol
protocol NewJobOrderPopupViewControllerProtocol {
    func reloadData(_ viewController: NewJobOrderPopupViewController)
}

// MARK: - Properties/Overrides
class NewJobOrderPopupViewController: BaseViewController {
    
    var delegate: NewJobOrderPopupViewControllerProtocol?
    private var contentView: NewJobOrderPopupView?
    private var jobOrderProvider = BaseMoyaProvider<JobOrderService>()
    private lazy var presenter = NewJobOrderPopupPresenter(self, jobOrderProvider: jobOrderProvider)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.loadNibNamed("NewJobOrderPopupView")
        self.contentView = self.view as? NewJobOrderPopupView
    }
}

// MARK: - Lifecycle
extension NewJobOrderPopupViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.addKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.presenter.getAllJobStatus()
//        self.presenter.getAllClients()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        super.removeKeyboardObservers()
    }
}

// MARK: - Functions/Methods
extension NewJobOrderPopupViewController {
    func setupViews() {
        self.contentView?.delegate = self
        self.contentView?.titleTextField.delegate = self
        
        self.contentView?.setupView()
    }
}

// MARK: - NewJobOrderPopupViewProtocol
extension NewJobOrderPopupViewController: NewJobOrderPopupViewProtocol {
    func createButtonHandler(_ view: NewJobOrderPopupView, jobOrder: JobOrder) {
        
        let address = Address()
        address.address1 = "10 Pitt Street"
        address.city = "Redfern"
        address.state = "New South Wales"
        address.postCode = "2016"
        address.active = true
        
        jobOrder.jobAddress = address
        jobOrder.priority = 1
        jobOrder.jobStatusID = 2121 // Data got from getAllJobStatus API
        jobOrder.clientID = 95878 // Data got from getAllClients API
        
        self.presenter.createNewJobOrder(jobOrder)
    }
    
    func closeButtonHandler(_ view: NewJobOrderPopupView) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - NewJobOrderPopupPresenterView
extension NewJobOrderPopupViewController: NewJobOrderPopupPresenterView {
    func successGetAllJobStatus(_ presenter: NewJobOrderPopupPresenter) {
    }
    
    func successGetAllClients(_ presenter: NewJobOrderPopupPresenter) {
    }
    
    func successCreateNewJobOrder(_ presenter: NewJobOrderPopupPresenter) {
        self.dismiss(animated: true) {
            self.delegate?.reloadData(self)
        }
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
extension NewJobOrderPopupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.contentView?.titleTextField {
            self.contentView?.descriptionTextView.becomeFirstResponder()
        }
        return true
    }
}
