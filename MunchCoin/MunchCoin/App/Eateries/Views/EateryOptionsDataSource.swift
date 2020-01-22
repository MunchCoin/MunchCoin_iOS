//
//  EateryOptionsDataSource.swift
//  MunchCoin
//
//  Created by Developer on 1/21/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

extension EateryOptionsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EateryOptionCell", for: indexPath) as! EateryOptionCollectionViewCell
        
        let title = titles[indexPath.row]
        
        switch title {
            case "PROMOTIONS":
                cell.setTitle(title, color: Branding.Color.darkBlue)
                cell.setBackground(color: .white)
                cell.setShadow(true)
        case "MENU":
            cell.setTitle(title, color: .white)
            cell.setBackground(color: Branding.Color.darkBlue)
            cell.setShadow(false)
        case "DIRECTIONS":
            cell.setTitle(title, color: .black)
            cell.setBackground(color: Branding.Color.yellow)
            cell.setShadow(false)
        default:
            break
        }
       
        
        return cell
    }
    
    


}
