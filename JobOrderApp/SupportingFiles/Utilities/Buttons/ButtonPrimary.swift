//
//  ButtonPrimary.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import UIKit

class ButtonPrimary: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    private func customize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.backgroundColor = JobOrderApp.Color.primary
        self.titleLabel?.font = UIFont(name: JobOrderApp.Font.primaryRegular, size: self.titleLabel?.font.pointSize ?? 13)
    }
}
