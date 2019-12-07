//
//  WalletTableViewDataSource.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

extension WalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        return sectionTitle == "Balance" ? balance != nil ? 1 : 0 : transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionTitle = sections[indexPath.section]
        switch sectionTitle {
        case   "Balance":
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceTableViewCell
            cell.configure()
            print(balance)
            let value = clean(token: balance!.value) ?? balance!.value
            cell.setBalance(value)
            cell.setCurrecny(balance!.currency)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
            cell.configureViews()
            let transaction = transactions![indexPath.row]
            let address =  transaction.positiveFlow ? transaction.from : transaction.to
            cell.set(amount: transaction.value, positiveFlow: transaction.positiveFlow)
            cell.set(address: address!, with: transaction.positiveFlow)
            return cell
        }
    }
}
