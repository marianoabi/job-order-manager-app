//
//  TextFieldPrimary.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import UIKit

class TextFieldPrimary: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    private func customize() {
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = color
        self.layer.cornerRadius = 5
        self.font = UIFont(name: JobOrderApp.Font.primaryRegular, size: self.font?.pointSize ?? 13)
    }
}
