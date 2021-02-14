//
//  BaseTableView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import UIKit

// MARK: - Properties/Overrides
class BaseTableViewCell: UITableViewCell {
    public var identifier: String! {
        return "\(self.typeName(self))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
}

// MARK: - Functions/Methods
extension BaseTableViewCell {
    func convertToNib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    func setupViews() {
        
    }
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
