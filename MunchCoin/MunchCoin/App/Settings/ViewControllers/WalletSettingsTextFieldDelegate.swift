//
//  WalletSettingsTextFieldDelegate.swift
//  MunchCoin
//
//  Created by Developer on 12/9/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

extension WalletSettingViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveValue()
        return true
    }
    
    
}
