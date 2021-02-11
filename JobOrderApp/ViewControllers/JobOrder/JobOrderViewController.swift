//
//  JobOrderViewController.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit


// MARK: - Properties/Overrides
class JobOrderViewController: BaseViewController {
    var contentView: JobOrderView?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadNibNamed("JobOrderView")
        self.contentView = self.view as? JobOrderView
    }
}

// MARK: - Lifecycle
extension JobOrderViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
