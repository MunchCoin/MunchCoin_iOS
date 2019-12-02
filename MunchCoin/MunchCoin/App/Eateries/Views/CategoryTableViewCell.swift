//
//  CategoryTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 11/28/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "CategoriesCell" }
    
    private var collectionView: UICollectionView = {
   
        let collectionLayout = UICollectionViewFlowLayout()
                collectionLayout.scrollDirection = .horizontal
                collectionLayout.itemSize = CGSize(width: 90, height: 122)
                collectionLayout.minimumInteritemSpacing = 0
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
    }()
    var categories: [Category]?
    var cellSelected: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            
            if let indexPath = cellSelected {
                indexPaths.append(indexPath)
            }
            
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            
            collectionView.reloadItems(at:indexPaths)
        }
    }
    var didSelect: ((Int) -> ())?
    
    
    func configure(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true

        contentView.addSubview(collectionView)
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionCell")
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.backgroundColor = Branding.Color.black
    }
    
    func set(_ categories: [Category]) {
        self.categories = categories
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}
