//
//  EateryTableViewDataSource.swift
//  MunchCoin
//
//  Created by Developer on 11/27/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

extension EateryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        
        var count = 0
        
        switch sectionTitle {
        case "Categories":
            count = categories != nil ? 1 : 0
        case "Eateries":
            count = filteredEateries?.count ?? 0
        case "Featured Eateries":
            count = filteredEateries != nil ? 1 : 0
        case "Popular Eateries":
            count = popularEateries != nil ? 1 : 0
        case "Options":
            count = 1
        case "Info":
            count = 1
        default:
            break
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionTitle = sections[indexPath.section]
        
        switch sectionTitle {
        case "Categories":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(sectionTitle)Cell", for: indexPath) as! CategoryTableViewCell
            cell.configure()
            cell.set(categories)
            cell.didSelect = {
                [weak self] index in
                if let row = cell.cellSelected?.row, index == row {
                    let selectedCategory = self?.categories[index].type
                    self?.filteredEateries = self?.eateries.filter {
                        eatery in
                        return eatery.categoryString == selectedCategory
                    }
                    
                } else {
                    self?.filteredEateries = self?.eateries ?? []
                }
                
                self?.featuredEateries = self?.filteredEateries.filter { eatery in return eatery.featured }.sorted {
                    eateryA, eateryB in
                    
                    return eateryA.featuredRank! < eateryB.featuredRank!
                }
                
                self?.tableView.reloadData()
            }
            cell.reloadCollectionView()
            return cell
        case "Eateries":
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(sectionTitle)Cell", for: indexPath) as! EateryTableViewCell
            let eatery = filteredEateries[indexPath.row]
            cell.configure()
            cell.set(title: eatery.name)
            cell.set(distance: "0.3mi")
            cell.set(subTitle: eatery.categoryString, and: eatery.verificationDate)
            
            return cell
        case "Featured Eateries":
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedCell", for: indexPath) as! FeaturedEateriesTableViewCell
            cell.eateries = featuredEateries
            cell.reload()
            return cell
            
        case "Popular Eateries":
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! PopularTableViewCell
            
            cell.eateries = popularEateries
            
            return cell

        case "Options":
            let cell = tableView.dequeueReusableCell(withIdentifier: "EateryOptionsCell", for: indexPath) as! EateryOptionsTableViewCell
            cell.reloadData()
            return cell
        case "Info":
            let cell = tableView.dequeueReusableCell(withIdentifier: "EateryInfoCell", for: indexPath) as! EateryInfoTableViewCell
            
            cell.categoryLabel.text = "Pizza"
            cell.certificationLabel.text = "Cerified 10/2/19"
            cell.phoneNumberLabel.text = "+1 (718) 796-0376"
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

