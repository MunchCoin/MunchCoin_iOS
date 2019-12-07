//
//  Transaction.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

struct Transaction {
    var value: String!
    var positiveFlow: Bool = false
    var to: String!
    var from: String!
}



func clean(token: String) -> String? {
    guard let amount = Double(token) else {
        return nil
    }

    
    let formatter = NumberFormatter()
    formatter.allowsFloats = true
    formatter.alwaysShowsDecimalSeparator = true
    formatter.usesSignificantDigits = true
    formatter.minimumSignificantDigits = 2
    formatter.maximumSignificantDigits = 2
    var val: String
    switch (true){
    case amount >= 1000000000:
        let divisor = amount/1000000000;
        let value = String(format: "%.2f", divisor)
        val = "\(value)b"
        
    case amount >= 1000000:
        let divisor = amount/1000000;
       let value = String(format: "%.2f", divisor)
        val = "\(value)m"
    case amount >= 1000:
        let divisor = amount/1000;
       let value = String(format: "%.2f", divisor)
        val = "\(value)k"
        
    default:
        val = "\(amount)"
    }
    
    return val
}
