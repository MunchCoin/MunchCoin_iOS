//
//  FeaturedEateriesCollectionDatatSource.swift
//  MunchCoin
//
//  Created by Developer on 1/18/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

extension FeaturedEateriesTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eateries?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedEateryCell", for: indexPath) as! FeaturedEateryCollectionViewCell
        
        let eatery = eateries![indexPath.row]
        cell.distanceLabel.text = eatery.distance ?? "0.3 mi"
        cell.categoryLabel.text = eatery.categoryString
        cell.locationTitleLabel.text = eatery.name
        
        guard let urlString = eatery.image else {
            return cell
        }
        
        guard let url = URL(string: urlString) else {
            return cell
        }
        
        cell.backgroundImageView.kf.setImage(with: url)
        
        return cell
    }
}
