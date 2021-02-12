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
    }
}

// MARK: - NewJobOrderPopupViewProtocol
extension NewJobOrderPopupViewController: NewJobOrderPopupViewProtocol {
    func createButtonHandler(_ view: NewJobOrderPopupView, jobOrder: JobOrder) {
        print("Create a new Job.....")
        
        let address = Address()
        address.address1 = "10 Pitt Street"
        address.city = "Redfern"
        address.state = "New South Wales"
        address.postCode = "2016"
        address.active = true
        
        jobOrder.jobAddress = address
        jobOrder.priority = 1
        jobOrder.jobStatusID = 2121
        jobOrder.clientID = 95878
        
        self.presenter.createNewJobOrder(jobOrder)
    }
    
    func closeButtonHandler(_ view: NewJobOrderPopupView) {
        print("Dismiss NewJobOrderPopupView.....")
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - NewJobOrderPopupPresenterView
extension NewJobOrderPopupViewController: NewJobOrderPopupPresenterView {
    func successGetAllJobStatus(_ presenter: NewJobOrderPopupPresenter) {
        print("Success GetAllJobStatus")
    }
    
    func failGetAllJobStatus(_ presenter: NewJobOrderPopupPresenter) {
        print("Fail GetAllJobStatus")
    }
    
    func successGetAllClients(_ presenter: NewJobOrderPopupPresenter) {
        print("Success GetAllClients")
    }
    
    func failGetAllClients(_ presenter: NewJobOrderPopupPresenter) {
        print("Fail GetAllClients")
    }
    
    func successCreateNewJobOrder(_ presenter: NewJobOrderPopupPresenter) {
        print("Success Create New Job Order....")
        self.dismiss(animated: true, completion: nil)
    }
    
    func failCreateNewJobOrder(_ presenter: NewJobOrderPopupPresenter) {
        print("Fail to Create New Job Order....")
    }
}
