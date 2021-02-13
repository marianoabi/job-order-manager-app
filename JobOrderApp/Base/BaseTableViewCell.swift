//
//  BaseTableView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    // MARK: - Properties
    public var identifier: String! {
        return "\(self.typeName(self))"
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: - Functions
    func convertToNib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    func setupViews() {
        
    }
    
    func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
