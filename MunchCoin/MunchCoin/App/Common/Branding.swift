//
//  Branding.swift
//  MunchCoin
//
//  Created by Developer on 11/29/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

struct Branding {
    struct Font {
        static var berlinRegular = "BerlinSansFB-Reg"
        static var berlinDemi = "BerlinSansFBDemi-Bold"
    }
    
    struct Color {
        static var black: UIColor { return UIColor(red: 0, green: 0, blue: 0, alpha: 1) }
        static var yellow: UIColor { return UIColor(red: 1, green: 216/255, blue: 97/255, alpha: 1) }
        static var grey: UIColor { return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5) }
        static var darkBlue: UIColor { return UIColor(red: 48/255, green: 50/255, blue: 61/255, alpha: 1)}
    }
    
}
