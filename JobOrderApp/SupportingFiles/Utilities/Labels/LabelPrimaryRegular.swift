//
//  LabelPrimaryRegular.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import UIKit

class LabelPrimaryRegular: UILabel {

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }

    func configureLabel() {
        self.font = UIFont(name: JobOrderApp.Font.primaryRegular, size: self.font.pointSize)
    }
}
