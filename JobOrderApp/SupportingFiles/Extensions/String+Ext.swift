//
//  String+Ext.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/12/21.
//

import Foundation

extension String {
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
