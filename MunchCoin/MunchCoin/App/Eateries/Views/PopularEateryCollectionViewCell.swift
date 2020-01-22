//
//  PopularEateryCollectionViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/19/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class PopularEateryCollectionViewCell: UICollectionViewCell {
    
    override var reuseIdentifier: String? { return "PopularEateryCell" }
    var eateryImageView: UIImageView = UIImageView()
    var distanceLabel: UILabel = UILabel()
    var locationTitleLabel: UILabel = UILabel()
    var categoryLabel: UILabel = UILabel()
    var containerView: UIView = UIView()
    var rankLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(containerView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(rankLabel)
        
        rankLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        rankLabel.textColor = .black
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        rankLabel.textAlignment = .right
        
        
        containerView.addSubview(eateryImageView)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.5
        
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 11).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        eateryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        eateryImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        eateryImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        eateryImageView.bottomAnchor.constraint(equalTo:containerView.bottomAnchor).isActive = true
        eateryImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        eateryImageView.layer.cornerRadius = 8
        eateryImageView.layer.masksToBounds = true
        
        distanceLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 14)
        distanceLabel.textColor = .black
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: eateryImageView.trailingAnchor, constant: 11).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        locationTitleLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        locationTitleLabel.textColor = .black
        locationTitleLabel.numberOfLines = 2
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.leadingAnchor.constraint(equalTo: eateryImageView.trailingAnchor, constant: 11).isActive = true
        locationTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        locationTitleLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor).isActive = true
        
        categoryLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 14)
        categoryLabel.textColor = Branding.Color.grey
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: eateryImageView.trailingAnchor, constant: 11).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
    }
    
}
