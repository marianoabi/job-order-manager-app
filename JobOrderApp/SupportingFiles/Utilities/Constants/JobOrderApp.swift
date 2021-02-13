//
//  JobOrderApp.swift
//  JobOrderApp
//
//  Created by Abigail Mariano on 2/11/21.
//

import UIKit

struct JobOrderApp {
    struct NotificationName {
        static let shouldGoToHomepage = "shouldGoToHomepage"
        static let shouldLogout = "shouldLogout"
    }
    
    struct Color {
        static let primary = UIColor(named: "primary")!
        static let secondary = UIColor(named: "secondary")!
        static let content = UIColor(named: "content")!
        static let error = UIColor(named: "error")!
        static let content50 = UIColor(named: "content50")!
        static let success = UIColor(named: "success")!
        static let brownGrey = UIColor(named: "brownGrey")!
    }
    
    struct ErrorMessage {
        static let byDefault = "An error ocurred."
        static let noToken = "No token found."
        static let passwordRequired = "Password is required."
        static let emailRequired = "Email is required."
        static let titleRequired = "Title is required."
        static let descriptionRequired = "Description is required."
    }
    
    struct Storyboard {
        
    }
    
    struct ViewController {
        
    }
    
    struct Nib {
        
    }
    
    struct Font {
        static let primaryRegular = "Comfortaa-Regular"
        static let primaryBold = "Comfortaa-Bold"
    }
}
