//
//  DatePickerTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    override var reuseIdentifier: String? { return "DatePickerCell"}
    var datePicker: UIDatePicker = UIDatePicker()
    var initialDate: Date?
    var getDate: ((_ date: Date) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "AmountCell")
       configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(){
        let date = initialDate ?? Date()
        contentView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.maximumDate = date
        datePicker.setDate(date, animated: false)
        datePicker.addTarget(self, action: #selector(sendDate), for: .valueChanged)
    }
    
    @objc func sendDate() {
        getDate?(datePicker.date)
    }
}
