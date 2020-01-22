//
//  FeaturesCellTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/18/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class FeaturedEateriesTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "FeaturedCell" }
    
    var eateries: [Eatery]?
    private var featuredEateriesCollectionView: UICollectionView = {
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 193, height: 106)
        collectionLayout.minimumInteritemSpacing = 16
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        featuredEateriesCollectionView.register(FeaturedEateryCollectionViewCell.self, forCellWithReuseIdentifier: "FeaturedEateryCell")
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
        contentView.addSubview(featuredEateriesCollectionView)
        
        featuredEateriesCollectionView.dataSource = self
        featuredEateriesCollectionView.delegate = self
        featuredEateriesCollectionView.allowsMultipleSelection = false
        featuredEateriesCollectionView.allowsSelection = false
        featuredEateriesCollectionView.backgroundColor = Branding.Color.yellow
        featuredEateriesCollectionView.showsHorizontalScrollIndicator = false
        
        
        featuredEateriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featuredEateriesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        featuredEateriesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        featuredEateriesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        featuredEateriesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    
    func reload() {
        featuredEateriesCollectionView.reloadData()
    }
    
}
