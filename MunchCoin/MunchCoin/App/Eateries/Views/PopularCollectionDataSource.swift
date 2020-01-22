//
//  PopularCollectionDataSource.swift
//  MunchCoin
//
//  Created by Developer on 1/19/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

extension PopularTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eateries?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularEateryCell", for: indexPath) as! PopularEateryCollectionViewCell
        
        let eatery = eateries![indexPath.row]
        cell.distanceLabel.text = eatery.distance ?? "0.3 mi"
        cell.categoryLabel.text = eatery.categoryString
        cell.locationTitleLabel.text = eatery.name
        cell.rankLabel.text = "\(indexPath.row + 1)."
        guard let urlString = eatery.image else {
            return cell
        }

        
//        let urlString = "https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?cs=srgb&dl=food-dinner-lunch-unhealthy-70497.jpg&fm=jpg"
        
        
        guard let url = URL(string: urlString) else {
            return cell
        }
        
        cell.eateryImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
