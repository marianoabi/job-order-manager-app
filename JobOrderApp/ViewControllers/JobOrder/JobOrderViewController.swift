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
        self.fetchAllJobOrders()
    }
}

// MARK: - Methods
extension JobOrderViewController {
    private func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.contentView?.jobOrderTableView.register(UINib(nibName: "JobOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "JobOrderTableViewCell")
        self.contentView?.jobOrderTableView.delegate = self
        self.contentView?.jobOrderTableView.dataSource = self
    }
    
    private func fetchAllJobOrders() {
        self.presenter.getAllJobs()
    }
}

// MARK: - UICollectionViewDelegate
extension JobOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UICollectionViewDataSource
extension JobOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobOrders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobOrderTableViewCell", for: indexPath) as? JobOrderTableViewCell
        
        if let jobOrder = self.jobOrders?[indexPath.row] {
            cell?.updateData(with: jobOrder)
            
            var clientTest = jobOrder.clients!
            clientTest.append(clientTest[0])
            clientTest.append(clientTest[0])
//            cell?.clients = jobOrder.clients
            cell?.clients = clientTest
        }
        
        return cell!
    }
}

// MARK: - JobOrderPresenterView
extension JobOrderViewController: JobOrderPresenterView {
    func successFetchJobOrders(_ presenter: JobOrderPresenter, jobOrders: [JobOrder]) {
        print("Success fetch job orders.....")
        self.jobOrders = jobOrders
    }
    
    func failFetchJobOrders(_ presenter: JobOrderPresenter) {
        print("Fail fetch job orders.....")
    }
}
