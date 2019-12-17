//
//  WalletViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    var sections = ["Balance", "History"]
    var balance: (value:String, currency:String?)?
    var transactions: [Transaction]?
    var tableView: UITableView = UITableView()
    var walletAddress: String?
    var network: Network = Network.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let address = UserDefaults.standard.string(forKey: "DefaultAddress") else {
            configureNoAddressView()
            return
        }
        self.walletAddress = address
        configureViews()
        getBalance() {
             [weak self] balance in
            self?.getTransactions() {
               transactions, decimal in
                var value = balance
                value.removeLast(decimal!)
                self?.balance = (value, nil)
                self?.transactions = transactions
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func configureViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.register(BalanceTableViewCell.self, forCellReuseIdentifier: "BalanceCell")
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionCell")
        
        tableView.allowsSelection = false
    }
    
    func configureNoAddressView(){
        let controller = PromptController(title: "uh oh!", message: "Add your Ethereum wallet address to view MunchCoin transactions.", prompt: "Add Address", action: {}, backgroundImage: UIImage(named: "backgroundLogo"))
        view.addSubview(controller.view)
        controller.view.backgroundColor = Branding.Color.yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
    
    func getBalance(completion: @escaping (String) -> ()) {
        var balanceURL = "https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=\(EtherScanParams.contractAddress)&address=\(walletAddress!)&tag=latest&apikey=\(EtherScanParams.apiKey)"
        let url = URL(string: balanceURL)!
        network.getData(from: url){
            data in
            
            guard let data = data else {
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                return
            }
            guard let result = json as? [String:String] else {
                return
            }
            
            guard result["status"] == "1" else {
                return
            }
            
           completion(result["result"]!)
        }
    }
    
    func getTransactions(completion: @escaping ([Transaction], Int?)->()) {
        var transactionURL = "https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=\(EtherScanParams.contractAddress)&address=\(walletAddress!)&page=1&sort=asc&apikey=\(EtherScanParams.apiKey)"
        let url = URL(string:transactionURL)!
        
        network.getData(from: url){
            [walletAddress]
            data in
            guard let data = data else {
                print("no data retrieved")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                print("decoding failed")
                return
            }
            print(json)
            guard let result = json as? [String:Any] else {
                print("conversion failed")
                return
            }
            
            guard result["status"] as? String == "1" else {
                return
            }
            
            
            guard let txObjects = result["result"] as? [[String:Any]] else {
                print("failed converting transactions")
                return
            }
            var decimal: Int?
            
            let transactions: [Transaction] = txObjects.map {
                tx in
                var transaction = Transaction()
                decimal = Int(tx["tokenDecimal"] as! String)!
                var value = (tx["value"] as! String)
                value.removeLast(decimal!)
                transaction.value = value
                let to = (tx["to"] as! String)
                let from = (tx["from"] as! String)
                transaction.to = to
                transaction.from = from
                transaction.positiveFlow = to == walletAddress!
                return transaction
            }
            
            completion(transactions, decimal)
        }
    }
}
