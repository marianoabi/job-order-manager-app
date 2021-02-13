//
//  NewJobOrderPopupViewController.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import UIKit

// MARK: - Properties/Init
class NewJobOrderPopupViewController: BaseViewController {
    
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

        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.presenter.getAllJobStatus()
//        self.presenter.getAllClients()
    }
}

// MARK: - Methods
extension NewJobOrderPopupViewController {
    func setupView() {
        self.contentView?.delegate = self
        self.contentView?.showErrorMessage(false)
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func onError(error: String) {
        self.contentView?.showErrorMessage(true, with: error)
    }
}
