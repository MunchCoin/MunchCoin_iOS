//
//  PopularTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/19/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    var eateries: [Eatery]?
    var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 251, height: 75)
        collectionLayout.minimumInteritemSpacing = 16
        collectionLayout.minimumLineSpacing = 16
        collectionLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
    }()
    
    override var reuseIdentifier: String? { return "PopularCell" }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.register(PopularEateryCollectionViewCell.self, forCellWithReuseIdentifier: "PopularEateryCell")
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
  
    
    func configure() {
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.backgroundColor = Branding.Color.lightGrey
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
