//
//  JobOrderViewController.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit


// MARK: - Properties/Overrides
class JobOrderViewController: BaseViewController {
    var contentView: JobOrderView?
    private var jobOrderProvider = BaseMoyaProvider<JobOrderService>()
    private lazy var presenter = JobOrderPresenter(self, jobOrderProvider: jobOrderProvider)
    
    private var jobOrders: [JobOrder]? {
        didSet {
            self.contentView?.jobOrderTableView.reloadData()
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadNibNamed("JobOrderView")
        self.contentView = self.view as? JobOrderView
    }
}

// MARK: - Lifecycle
extension JobOrderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.fetchAllJobOrders()
    }
}

// MARK: - Methods
extension JobOrderViewController {
    private func setupViews() {
        self.contentView?.jobOrderTableView.register(JobOrderTableViewCell().convertToNib(), forCellReuseIdentifier: JobOrderTableViewCell().identifier)
        self.contentView?.jobOrderTableView.delegate = self
        self.contentView?.jobOrderTableView.dataSource = self
        
        self.contentView?.delegate = self
    }
    
    private func fetchAllJobOrders() {
        self.presenter.getAllJobs()
    }
    
    private func pullToRefresh() {
        self.fetchAllJobOrders()
    }
}

// MARK: - UICollectionViewDelegate
extension JobOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let tableView = self.contentView?.jobOrderTableView else { return }
        
        let contentYoffset = scrollView.contentOffset.y
        
        if scrollView.contentSize.height >= tableView.bounds.height * 0.9 {
            if contentYoffset <= -50 {
                self.pullToRefresh()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension JobOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobOrders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobOrderTableViewCell().identifier, for: indexPath) as? JobOrderTableViewCell
        
        if let jobOrder = self.jobOrders?[indexPath.row] {
            cell?.updateData(with: jobOrder)
        }
        
        return cell!
    }
}

// MARK: - JobOrderPresenterView
extension JobOrderViewController: JobOrderPresenterView {
    func successFetchJobOrders(_ presenter: JobOrderPresenter, jobOrders: [JobOrder]) {
        self.jobOrders = jobOrders
    }
    
    func onLoadingStart() {
        self.showLoadingProgress()
    }
    
    func onLoadingEnd() {
        self.hideLoadingProgress()
    }
}

// MARK: - JobOrderViewProtocol
extension JobOrderViewController: JobOrderViewProtocol {
    func createButtonHandler(_ view: JobOrderView) {
        self.goToNewJobOrderPopup(self, delegate: self)
    }
    
    func logoutButtonHandler(_ view: JobOrderView) {
        
        let alert = UIAlertController(title: "Logout",
                                      message: "Are you sure you want to logout?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertAction.Style.default, handler: { _ in
            NotificationCenter.default.post(name: .shouldLogout, object: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - JobOrderViewProtocol
extension JobOrderViewController: NewJobOrderPopupViewControllerProtocol {
    func reloadData(_ viewController: NewJobOrderPopupViewController) {
        self.fetchAllJobOrders()
    }
}
