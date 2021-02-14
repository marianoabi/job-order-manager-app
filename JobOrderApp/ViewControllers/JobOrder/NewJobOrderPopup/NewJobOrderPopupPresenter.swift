//
//  NewJobOrderPopupPresenter.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import Moya_ObjectMapper
import Moya

// MARK: - Protocol
protocol NewJobOrderPopupPresenterView: BasePresenterView {
    func successCreateNewJobOrder(_ presenter: NewJobOrderPopupPresenter)
    func successGetAllJobStatus(_ presenter: NewJobOrderPopupPresenter)
    func successGetAllClients(_ presenter: NewJobOrderPopupPresenter)
}

// MARK: - Properties/Overrides
class NewJobOrderPopupPresenter {
    var view: NewJobOrderPopupPresenterView?
    var jobOrderProvider: BaseMoyaProvider<JobOrderService>?
    
    init(_ view: NewJobOrderPopupPresenterView, jobOrderProvider: BaseMoyaProvider<JobOrderService>) {
        self.view = view
        self.jobOrderProvider = jobOrderProvider
    }
}

// MARK: - API Calls
extension NewJobOrderPopupPresenter {
    func createNewJobOrder(_ newJobOrder: JobOrder) {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.createJobOrder(jobOrder: newJobOrder), completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                self.view?.onLoadingEnd?()
            
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let _ = try? response.mapObject(JobOrder.self)
                    
                    self.view?.successCreateNewJobOrder(self)

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
                self.view?.onError?(error: error.errorDescription ?? JobOrderApp.ErrorMessage.byDefault)
                self.view?.onLoadingEnd?()
            }
        })
    }
    
    func getAllJobStatus() {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.getAllJobStatus, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.view?.successCreateNewJobOrder(self)
                self.view?.onLoadingEnd?()
                
            case let .failure(error):
                self.view?.onError?(error: error.errorDescription ?? JobOrderApp.ErrorMessage.byDefault)
            self.view?.onLoadingEnd?()
            }
        })
    }
    
    func getAllClients() {
        self.view?.onLoadingStart?()
        self.jobOrderProvider?.request(.getAllClients, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.view?.successGetAllClients(self)
                self.view?.onLoadingEnd?()
                
            case let .failure(error):
            self.view?.onError?(error: error.errorDescription ?? JobOrderApp.ErrorMessage.byDefault)
            self.view?.onLoadingEnd?()
            }
        })
    }
}
