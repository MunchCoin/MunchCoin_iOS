//
//  CategortCollectionViewCell.swift
//  MunchCoin
//
//  Created by Developer on 11/28/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView = UIImageView()
    private var categoryLabel: UILabel = UILabel()
    private var stackView: UIStackView = UIStackView()
    private var imageFilter: UIView = UIView()
    private var containerView: UIView = UIView()
    
//r
    
    override var reuseIdentifier: String? { return "CatergoriesCollectionCell" }
    
    func configure() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        containerView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        containerView.clipsToBounds = false
        containerView.addSubview(imageView)
        containerView.addSubview(imageFilter)
        containerView.bringSubviewToFront(imageFilter)
        
        // Image View
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.layer.cornerRadius = 75 / 2
        imageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        imageFilter.backgroundColor = Branding.Color.yellow
        imageFilter.alpha = 0.0
        imageFilter.translatesAutoresizingMaskIntoConstraints = false
        imageFilter.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageFilter.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        imageFilter.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageFilter.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        // Category Label
        categoryLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
        categoryLabel.textColor = .white
        
        // Stackview
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(categoryLabel)
        
    }
    
    func setImage(with urlString: String?) {
        guard let urlString = urlString else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        imageView.kf.setImage(with: url)
    }
    func set(title to: String){
        categoryLabel.text = to
    }
    
    func setUI(for selected: Bool){
        let color = selected ?  UIColor.white : Branding.Color.yellow
        imageView.layer.borderColor = color.cgColor
        imageFilter.alpha = selected ? 0 : 0.3
        categoryLabel.textColor = color
        
    }
}
