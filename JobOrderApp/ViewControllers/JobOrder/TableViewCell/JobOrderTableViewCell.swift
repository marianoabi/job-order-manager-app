//
//  JobOrderTableViewCell.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

class JobOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    
    var clients: [Client]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateData(with jobOrder: JobOrder) {
//        self.wrapperView.addShadow()

        self.titleLabel.text = jobOrder.title
        
        if let status = jobOrder.status {
            self.setupJobStatus(status)
        }
        
        if let referenceID = jobOrder.referenceID {
            self.referenceNoLabel.text = "\(referenceID)"
        }
        
        if let client = jobOrder.clients?.first {
            self.clientNameLabel.text = "\(client.firstName ?? "") \(client.lastName ?? "")"
            self.companyNameLabel.text = client.company
        }
        
        
        if let jobAddress = jobOrder.jobAddress {
            self.addressLabel.text = "\(jobAddress.address1 ?? "") \(jobAddress.city ?? "") \(jobAddress.state ?? "") \(jobAddress.postCode ?? "")"
        }
        
        if let desc = jobOrder.description {
            self.descriptionLabel.text = desc.htmlAttributedString?.string
        }
        
        self.wrapperView.addShadow()
    }
    
    private func setupJobStatus(_ status: JobStatus) {
        self.statusLabel.text = status.name
//        self.statusLabel.textColor = UIColor.green
    }
}
