//
//  AmountTableViewCellTextFieldDelegate.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

extension AmountTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        getAmount?(textField.text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {
            return true
        }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return isValid(replacementText)
    }
    
    func isValid(_ string: String) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeperator = formatter.decimalSeparator ?? "."
        
        if formatter.number(from: string) != nil {
            let split = string.components(separatedBy: decimalSeperator)
            
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            return digits.count <= 2
        }
        
        return false
    }
    
}
