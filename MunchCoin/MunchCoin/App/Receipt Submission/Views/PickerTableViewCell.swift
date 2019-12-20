//
//  PickerTableViewCell.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    override var reuseIdentifier: String? { return "PickerCell" }
    var pickerView: UIPickerView = UIPickerView()
    var values: [String]?
    var getValue: ((_ at: Int) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "AmountCell")
       configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        contentView.addSubview(pickerView)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}

extension PickerTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values?.count ?? 0
    }
}

extension PickerTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getValue?(row)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values![row]
    }
}
