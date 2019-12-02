//
//  CatergoyCollectionDatasource.swift
//  MunchCoin
//
//  Created by Developer on 11/29/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.configure()
        let category = categories![indexPath.row]
        let urlString = category.imageURLString
        cell.setUI(for: cellSelected != indexPath)
        cell.setImage(with: urlString)
        cell.set(title: category.type)
        return cell
    }
    
}
