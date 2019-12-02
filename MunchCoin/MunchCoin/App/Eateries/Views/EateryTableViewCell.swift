//
//  EateryTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 11/28/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EateryTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "EateriesCell"}
    private var mainStackView: UIStackView = UIStackView()
    private var topLabelStackView: UIStackView = UIStackView()
    private var bottomLabelStackView: UIStackView = UIStackView()
    private var eateryLabel: UILabel = UILabel()
    private var distanceLabel: UILabel = UILabel()
    private var subTitleLabel: UILabel = UILabel()
    private var category: String?
    func configure() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        contentView.backgroundColor = .black
        
        // Eatery Label
        eateryLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 17)

        // Distance Label
        distanceLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 12)
        
        // Subtitle Label
        subTitleLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 15)
        subTitleLabel.textColor = Branding.Color.grey
        
        // Top Label StackView
        topLabelStackView.axis = .horizontal
        topLabelStackView.alignment = .bottom
        topLabelStackView.distribution = .fillProportionally
        topLabelStackView.spacing = 8
        topLabelStackView.addArrangedSubview(eateryLabel)
        topLabelStackView.addArrangedSubview(distanceLabel)
        
        // Bottom Label StackView
        bottomLabelStackView.axis = .horizontal
        bottomLabelStackView.alignment = .top
        bottomLabelStackView.distribution = .fillProportionally
        bottomLabelStackView.addArrangedSubview(subTitleLabel)
        
        // Main StackView
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .fillEqually
        mainStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        mainStackView.addArrangedSubview(topLabelStackView)
        mainStackView.addArrangedSubview(bottomLabelStackView)
        
    }
    
    func set(title to: String) {
        eateryLabel.text = to
    }
    
    func set(subTitle to: String?, and  also: String) {
        subTitleLabel.text = "\(to ?? "") \u{2022} \(also)"
    }
    
    func set(distance to: String) {
        distanceLabel.text = to
    }
    
    func getCategory() -> String? {
        return self.category
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        contentView.backgroundColor = selected ? Branding.Color.yellow : .systemBackground
        eateryLabel.textColor = selected ? .black : .label
        subTitleLabel.textColor = selected ? Branding.Color.grey : .systemGray
        distanceLabel.textColor = selected ? .black : .label
    }
}
