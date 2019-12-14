//
//  ErrorHandling.swift
//  MunchCoin
//
//  Created by Developer on 12/14/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

struct AlertSystem {
    enum AlertType {
        case standard
    }
    
    static func createAlert(title: String, message: String, type: AlertType = .standard) -> UIAlertController {
        let action: UIAlertAction
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        switch type {
        case .standard :
            action = UIAlertAction(title: "OK", style: .default)
        }
        
        alert.addAction(action)
        return alert
    }
}
