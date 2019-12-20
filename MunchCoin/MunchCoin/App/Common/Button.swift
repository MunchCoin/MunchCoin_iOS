//
//  Button.swift
//  MunchCoin
//
//  Created by Developer on 12/15/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case light, dark
}

class Button: UIButton {
    
    init(style: ButtonStyle = .light) {
        let frame = CGRect(x: 0, y: 0, width: 179, height: 50)
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 179).isActive = true
        titleLabel?.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        let color = Branding.Color.black
        backgroundColor = style == .light ? .white : Branding.Color.yellow
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 8
        
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        
        super.setTitle(title?.uppercased(), for: .normal)
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
