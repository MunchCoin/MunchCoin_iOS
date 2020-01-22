//
//  FeaturedEateryCollectionViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/19/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class FeaturedEateryCollectionViewCell: UICollectionViewCell {
    var backgroundImage: UIImage?
    var backgroundImageView: UIImageView = UIImageView()
    var distanceLabel: UILabel = UILabel()
    var locationTitleLabel: UILabel = UILabel()
    var categoryLabel: UILabel = UILabel()
    var filterView: UILabel = UILabel()
    
    override var reuseIdentifier: String? { return "FeaturedEateryCell" }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1
        
        contentView.addSubview(filterView)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        filterView.addSubview(distanceLabel)
        filterView.addSubview(locationTitleLabel)
        filterView.addSubview(categoryLabel)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        filterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        filterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        filterView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        distanceLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 14)
        distanceLabel.textColor = Branding.Color.yellow
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 11).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 11).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -11).isActive = true
        
        
        categoryLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 14)
        categoryLabel.textColor = Branding.Color.yellow
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: -11).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 11).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -11).isActive = true
        
        locationTitleLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        locationTitleLabel.textColor = .white
        locationTitleLabel.numberOfLines = 2
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 11).isActive = true
        locationTitleLabel.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -11).isActive = true
        locationTitleLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor).isActive = true
        
        backgroundView = backgroundImageView
        
        backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundImageView.layer.cornerRadius = 8
        backgroundImageView.layer.masksToBounds = true
   
        
        
        
    }
}
