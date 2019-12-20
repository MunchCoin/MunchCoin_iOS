//
//  AmountTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class AmountTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "AmountCell" }
    var textField: UITextField = UITextField()
    var getAmount: ((String?) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "AmountCell")
       configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure() {
        contentView.addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 43))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.placeholder = "Reciept Amount"
        textField.autocorrectionType = .no
        textField.clearButtonMode = .always
        textField.clearsOnInsertion = true
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .next
        textField.spellCheckingType = .no
        textField.delegate = self
        textField.returnKeyType = .done
        textField.textAlignment = .right
    }
}
