//
//  BaseView.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

// MARK: - Properties/Overrides
class BaseView: UIView {
    public var identifier: String! {
        return "\(self.typeName(self))"
    }
    
    func initView() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
}

// MARK: - Functions/Methods
extension BaseView {
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
