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
        return sectionTitle == "Categories" ? categories != nil ? 1 : 0 : filteredEateries?.count ?? 0
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
                if let row = cell.cellSelected?.row , index == row {
                    let selectedCategory = self?.categories[index].type
                    self?.filteredEateries = self?.eateries.filter {
                        eatery in
                        return eatery.categoryString == selectedCategory
                    }
                } else {
                    self?.filteredEateries = self?.eateries ?? []
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
        default:
            return UITableViewCell()
        }
    }
}

