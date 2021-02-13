//
//  UIView+Ext.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import UIKit

extension UIView {
    
    enum ViewBorder: String {
        case left
        case right
        case top
        case bottom
    }
    
    func addShadow(cornerRadius: CGFloat = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
    }
    
    func add(Border border: ViewBorder, withColor color: UIColor = UIColor.systemGray5, andWidth width: CGFloat = 1.0) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        NSLayoutConstraint.activate(getConstrainsFor(forView: borderView, WithBorderType: border, andWidth: width))
    }
    
    private func getConstrainsFor(forView borderView: UIView, WithBorderType border: ViewBorder, andWidth width: CGFloat) -> [NSLayoutConstraint] {
        
        let height = borderView.heightAnchor.constraint(equalToConstant: width)
        let widthAnchor = borderView.widthAnchor.constraint(equalToConstant: width)
        let leading = borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailing = borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let top = borderView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottom = borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        switch border {
        case .bottom:
            return [bottom, leading, trailing, height]
            
        case .top:
            return [top, leading, trailing, height]
            
        case .left:
            return [top, bottom, leading, widthAnchor]
            
        case .right:
            return [top, bottom, trailing, widthAnchor]
        }
    }
}
