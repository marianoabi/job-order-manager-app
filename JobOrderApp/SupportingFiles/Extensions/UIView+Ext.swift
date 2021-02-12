//
//  UIView+Ext.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import UIKit

extension UIView {
    func addShadow(cornerRadius: CGFloat = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
    }
}
