//
//  EateryViewController.swift
//  MunchCoin
//
//  Created by Developer on 11/27/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EateryViewController: UIViewController {
    
    var tableView: UITableView! = UITableView()
    var sections: [String] = ["Categories", "Eateries"]
    var categories: [Category]!
    var eateries: [Eatery]!
    var filteredEateries: [Eatery]!
    var network = Network.shared
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        
        tableView.register(EateryTableViewCell.self, forCellReuseIdentifier: "EateriesCell")
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoriesCell")
        
        network.get("Categories", converted: {
            data -> Category in
            
            var category = Category()
            category.type = (data["type"] as! String)
            category.imageURLString = data["imageURLString"] as? String
            category.id = (data["id"] as! String)
            return category
            
        }) {
            [weak self]
            result in
          
            self?.categories = result ?? []
            self?.tableView.reloadData()
        }
        
        network.get("Eateries", converted: {
            [weak self]
            data -> Eatery in
            
            var eatery = Eatery()
            eatery.name = (data["name"] as! String)
            eatery.address = (data["address"] as! String)
            eatery.verificationDate = (data["verificationDate"] as! String)
            eatery.category = (data["category"] as! DocumentReference)
            eatery.location = (data["location"] as! GeoPoint)
            eatery.id = (data["id"] as! String)
            self?.network.set(location: eatery.location, for: eatery.id)
            
            
            return eatery
        }) {
            [weak self]
            result in
            
            guard let eateries = result else {
                return
            }
            self?.eateries = []
            for eatery in eateries {
                eatery.category.getDocument {
                    [eatery]
                    snapshot, error in
                    
                    guard let snapshot = snapshot else {
                        return
                    }
                    
                    guard let data = snapshot.data() else {
                        return
                    }
                    var eatery = eatery
                    eatery.categoryString = (data["type"] as! String)
                    eatery.categoryID = snapshot.documentID
                    self?.eateries.append(eatery)

                    if self?.eateries.count == eateries.count {
                        self?.filteredEateries = self?.eateries
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func configureViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
      
        let safeLayout = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeLayout.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0 ).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
