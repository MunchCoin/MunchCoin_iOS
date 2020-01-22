//
//  EateryOptionsTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 1/20/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class EateryOptionsTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView = {
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width:  UIScreen.main.bounds.width - 32, height: 49)
        collectionLayout.minimumInteritemSpacing = 16
        collectionLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
    }()
    
     var titles = ["PROMOTIONS", "MENU", "DIRECTIONS"]
    
    override var reuseIdentifier: String? { return "EateryOptionsCell" }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EateryOptionCollectionViewCell.self, forCellWithReuseIdentifier: "EateryOptionCell")
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView() {
        contentView.addSubview(collectionView)
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .systemBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
    }
    
    func reloadData(){
        collectionView.reloadData()
    }

}
