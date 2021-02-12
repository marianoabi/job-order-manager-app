//
//  NewJobOrderPopupPresenter.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import Moya_ObjectMapper

protocol NewJobOrderPopupPresenterView: BasePresenterView {
    func successCreateNewJobOrder(_ presenter: NewJobOrderPopupPresenter)
    func failCreateNewJobOrder(_ presenter: NewJobOrderPopupPresenter)
    func successGetAllJobStatus(_ presenter: NewJobOrderPopupPresenter)
    func failGetAllJobStatus(_ presenter: NewJobOrderPopupPresenter)
    func successGetAllClients(_ presenter: NewJobOrderPopupPresenter)
    func failGetAllClients(_ presenter: NewJobOrderPopupPresenter)
}

class NewJobOrderPopupPresenter {
    var view: NewJobOrderPopupPresenterView?
    var jobOrderProvider: BaseMoyaProvider<JobOrderService>?
    
    init(_ view: NewJobOrderPopupPresenterView, jobOrderProvider: BaseMoyaProvider<JobOrderService>) {
        self.view = view
        self.jobOrderProvider = jobOrderProvider
    }
}

extension NewJobOrderPopupPresenter {
    func createNewJobOrder(_ newJobOrder: JobOrder) {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.createJobOrder(jobOrder: newJobOrder), completion: { result in
            
            switch result {
            case let .success(response):
                print("Success New Job \(response)")
                self.view?.successCreateNewJobOrder(self)
                self.view?.onLoadingEnd?()
                
            case let .failure(error):
                self.view?.onError?(error: error.errorDescription ?? "An error ocurred.")
                self.view?.failCreateNewJobOrder(self)
                self.view?.onLoadingEnd?()
            }
        })
    }
    
    func getAllJobStatus() {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.getAllJobStatus, completion: { result in
            
            switch result {
            case let .success(response):
                print("getAllJobStatus response: \(response)")
                self.view?.successCreateNewJobOrder(self)
                self.view?.onLoadingEnd?()
                
            case let .failure(error):
            self.view?.onError?(error: error.errorDescription ?? "An error ocurred.")
            self.view?.failGetAllJobStatus(self)
            self.view?.onLoadingEnd?()
            }
        })
    }
    
    func getAllClients() {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.getAllClients, completion: { result in
            
            switch result {
            case let .success(response):
                print("getAllClients response: \(response)")
                self.view?.successGetAllClients(self)
                self.view?.onLoadingEnd?()
                
            case let .failure(error):
            self.view?.onError?(error: error.errorDescription ?? "An error ocurred.")
            self.view?.failGetAllClients(self)
            self.view?.onLoadingEnd?()
            }
        })
    }
}
