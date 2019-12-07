//
//  WalletTableViewDelegate.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 122 : 70
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                
        return section == 0 ? walletAddress : sections[section]
      }
      
      func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
          let header = (view as! UITableViewHeaderFooterView)
          header.textLabel?.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
          switch section {
          case 0:
              header.textLabel?.textColor = Branding.Color.yellow
              header.contentView.backgroundColor = Branding.Color.black
          default:
              header.textLabel?.textColor = Branding.Color.black
              header.contentView.backgroundColor = .systemBackground
              header.textLabel?.textColor = .label
          }
      }
      
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 43.0
      }
}
