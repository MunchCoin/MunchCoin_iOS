//
//  TransactionTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? {return "TransactionCell"}
    private var amountLabel: UILabel = UILabel()
    private var addressLabel: UILabel = UILabel()
    private var stackView: UIStackView = UIStackView()
    private var positiveFlow: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureViews() {
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.alignment = .leading
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        
        amountLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 24)

        addressLabel.textColor = .systemGray
        addressLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 14)
        
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(addressLabel)
        
    }
    
    func set(address: String, with positiveFlow: Bool) {
        addressLabel.text = positiveFlow ? "from: \(address)" : "to: \(address)"
    }
    
    func set(amount: String, positiveFlow: Bool) {
        self.positiveFlow = positiveFlow
        let value = clean(token: amount) ?? amount

        amountLabel.text = positiveFlow ? "+\(value)" : "-\(value)"
        amountLabel.textColor = positiveFlow ? Branding.Color.yellow : .label
        addressLabel.textColor = .systemGray
    }
}
