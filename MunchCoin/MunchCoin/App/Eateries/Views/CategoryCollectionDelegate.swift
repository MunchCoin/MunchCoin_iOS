//
//  CategoryCollectionDelegate.swift
//  MunchCoin
//
//  Created by Developer on 11/29/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionCell", for: indexPath) as! CategoryCollectionViewCell

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionCell", for: indexPath) as! CategoryCollectionViewCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionCell", for: indexPath) as! CategoryCollectionViewCell
        if cellSelected == indexPath {
            cellSelected = nil
            collectionView.deselectItem(at: indexPath, animated: true)
            collectionView.reloadData()
            
        } else {
            cellSelected = indexPath
           
        }
        
         didSelect?(indexPath.row)
       
        
        return !cell.isSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}
