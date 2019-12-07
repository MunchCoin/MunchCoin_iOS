//
//  BalanceTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "BalanceCell" }
    
    private var stackView: UIStackView = UIStackView()
    private var balanceLabel: UILabel = UILabel()
    private var currencyLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        balanceLabel.textColor = Branding.Color.yellow
        balanceLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 36)
        stackView.addArrangedSubview(balanceLabel)
        
        currencyLabel.textColor = .white
        currencyLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
        stackView.addArrangedSubview(currencyLabel)
        
        contentView.backgroundColor = .black
    }
    
    func setBalance(_ balance: String) {
        balanceLabel.text = balance
    }
    
    func setCurrecny(_ amount: String?){
        currencyLabel.text = amount
    }

}
