//
//  SettingsTableViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var settings: [String] = ["Update Wallet Address"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Branding.Color.yellow
        tableView.allowsSelection = true
        tableView.tableFooterView = configureFooterView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        
    }
    
    func configureFooterView() -> UIView {
        let font = UIFont(name: Branding.Font.berlinRegular, size: 14)
        let versionLabel = UILabel()
        versionLabel.textColor = .systemGray
        versionLabel.font = font
        
        let messageLabel = UILabel()
        messageLabel.textColor = .black
        messageLabel.font = font
        messageLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [versionLabel, messageLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 110))
        view.heightAnchor.constraint(equalToConstant: 110).isActive = true
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        return view
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.backgroundColor = Branding.Color.yellow
        cell.textLabel?.textColor = cell.isSelected ? .white : .black
        cell.textLabel?.text = settings[indexPath.row]
        cell.textLabel?.highlightedTextColor = .white
        
        return cell
    }

}
