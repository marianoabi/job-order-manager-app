//
//  JobOrderPresenter.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Moya_ObjectMapper

protocol JobOrderPresenterView: BasePresenterView {
    func successFetchJobOrders(_ presenter: JobOrderPresenter, jobOrders: [JobOrder])
    func failFetchJobOrders(_ presenter: JobOrderPresenter)
}

class JobOrderPresenter {
    var view: JobOrderPresenterView?
    var jobOrderProvider: BaseMoyaProvider<JobOrderService>?
    
    init(_ view: JobOrderPresenterView, jobOrderProvider: BaseMoyaProvider<JobOrderService>) {
        self.view = view
        self.jobOrderProvider = jobOrderProvider
    }
}

extension JobOrderPresenter {
    func getAllJobs() {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.getJobOrders, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                if let jobOrders = try? response.mapArray(JobOrder.self) {
                    self.view?.successFetchJobOrders(self, jobOrders: jobOrders)
                }
                self.view?.onLoadingEnd?()
                
            case let .failure(error):
                self.view?.onLoadingEnd?()
                self.view?.onError?(error: error.errorDescription ?? "An error ocurred.")
                self.view?.failFetchJobOrders(self)
            }
        })
    }
}
