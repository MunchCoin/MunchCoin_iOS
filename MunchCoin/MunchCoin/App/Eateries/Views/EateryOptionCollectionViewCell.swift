//
//  EateryOptionCollectionViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/20/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class EateryOptionCollectionViewCell: UICollectionViewCell {
    
    private var backgroundImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var displayShadow: Bool!
 
    override var reuseIdentifier: String? { return "EateryOptionCell" }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    init(title: String, shadow: Bool = false) {
        let calcWidth = UIScreen.main.bounds.width - 32
        let frame = CGRect(x: 0, y: 0, width: calcWidth, height: 49)
        super.init(frame: frame)
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1

        
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
       
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    func setTitle(_ title: String, color: UIColor) {
        let title = NSMutableAttributedString(string: title)
        title.addAttribute(NSAttributedString.Key.kern, value: 1.0, range: NSRange(location: 0, length: title.length) )
        titleLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        titleLabel.textColor = color
        titleLabel.attributedText = title
    }
    
    func setBackground(image: UIImage) {
        backgroundImageView.image = image
    }
    
    func setBackground(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    func setShadow(_ bool: Bool) {
        layer.shadowOpacity = bool ? 0.5 : 0
    }
    
    
}
