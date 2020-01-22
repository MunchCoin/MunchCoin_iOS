//
//  EateryInfoTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/21/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class EateryInfoTableViewCell: UITableViewCell {
    
    var categoryLabel: UILabel = UILabel()
    var certificationLabel: UILabel = UILabel()
    var phoneNumberLabel: UILabel = UILabel()
    private var stackView: UIStackView = UIStackView()
    private var bottomStackView: UIStackView = UIStackView()
    
    override var reuseIdentifier: String? { return "EateryInfoCell" }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureView() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(certificationLabel)
        bottomStackView.addArrangedSubview(phoneNumberLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        categoryLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 16)
        categoryLabel.textColor = .black
        
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .center
        bottomStackView.distribution = .fillEqually
        
        
        certificationLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 16)
        certificationLabel.textColor = .black
        
        phoneNumberLabel.font =  UIFont(name: Branding.Font.berlinRegular, size: 16)
        phoneNumberLabel.textColor = Branding.Color.yellow
        phoneNumberLabel.textAlignment = .right
        
    }
}
