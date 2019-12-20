//
//  ReceiptImageTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ReceiptImageTableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? { return "ReceiptImageCell" }
    var receiptImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "AmountCell")
       configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure() {
        contentView.addSubview(receiptImageView)
        receiptImageView.translatesAutoresizingMaskIntoConstraints = true
        receiptImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        receiptImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

}
