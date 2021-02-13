//
//  JobOrderPresenter.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import Moya_ObjectMapper
import Moya

protocol JobOrderPresenterView: BasePresenterView {
    func successFetchJobOrders(_ presenter: JobOrderPresenter, jobOrders: [JobOrder])
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
                self.view?.onLoadingEnd?()

                do {
                    
                    _ = try response.filterSuccessfulStatusCodes()
                    if let jobOrders = try? response.mapArray(JobOrder.self) {
                        self.view?.successFetchJobOrders(self, jobOrders: jobOrders)
                    }
                    
                } catch(let error) {
                    if let error = error as? MoyaError {
                        do {
                            if let data = try error.response?.mapObject(BaseErrorResponse.self) {
                                
                                if let description = data.errorDescription {
                                    self.view?.onError?(error: description)

                                } else if let message = data.message {
                                    self.view?.onError?(error: message)

                                } else {
                                    self.view?.onError?(error: data.message ?? JobOrderApp.ErrorMessage.byDefault)
                                }
                            }
                            
                        } catch {
                            self.view?.onError?(error: JobOrderApp.ErrorMessage.byDefault)
                            
                        }
                        
                    } else {
                        
                        self.view?.onError?(error: JobOrderApp.ErrorMessage.byDefault)
                    }
                }
                
            case let .failure(error):
                self.view?.onLoadingEnd?()
                self.view?.onError?(error: error.errorDescription ?? JobOrderApp.ErrorMessage.byDefault)
            }
        })
    }
}
