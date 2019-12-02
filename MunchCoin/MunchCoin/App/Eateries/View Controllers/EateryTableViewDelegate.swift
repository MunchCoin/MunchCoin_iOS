//
//  EateryTableViewDelegate.swift
//  MunchCoin
//
//  Created by Developer on 11/27/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

extension EateryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionTitle = sections[indexPath.section]
        
        switch sectionTitle {
        case "Categories":
            break
        case "Eateries":
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionTitle = sections[indexPath.section]
        
        switch sectionTitle {
        case "Eateries":
            return 60
        case "Categories":
            return 122
        default:
            return 43
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
              
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = (view as! UITableViewHeaderFooterView)
        let sectionTitle = sections[section]
        header.textLabel?.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
        switch sectionTitle {
        case "Categories":
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
