//
//  ButtonTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "ButtonCell" }
    
    var button: Button = Button(style: .dark)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "AmountCell")
       configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.setTitle("Submit", for: .normal)
    }
}
