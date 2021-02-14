//
//  JobOrderTableViewCell.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

// MARK: - Properties/Overrides
class JobOrderTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
// MARK: - Functions/Methods
extension JobOrderTableViewCell {
    func updateData(with jobOrder: JobOrder) {
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

        if let hex = status.colorHex {
            self.statusLabel.textColor = hexStringToUIColor(hex: hex)
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
