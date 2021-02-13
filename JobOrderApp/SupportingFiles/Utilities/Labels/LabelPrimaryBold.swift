//
//  LabelPrimaryBold.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/13/21.
//

import UIKit

public class LabelPrimaryBold: UILabel {

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }

    func configureLabel() {
        self.font = UIFont(name: JobOrderApp.Font.primaryBold, size: self.font.pointSize)
    }
}
