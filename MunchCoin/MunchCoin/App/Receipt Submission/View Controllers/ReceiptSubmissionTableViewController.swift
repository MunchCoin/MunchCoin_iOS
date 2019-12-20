//
//  ReceiptSubmissionTableViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/16/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ReceiptSubmissionTableViewController: UITableViewController {
    
    enum CellType {
        case receiptImage, date, location, amount, walletAddress, submitButton, datePicker, picker
    }
    
    var types: [CellType] = [.receiptImage, .date, .location, .amount, .walletAddress, .submitButton]
    var values: [CellType:Any?] = [:]
    var locations: [Eatery]?
    var amount: Double?
    var address: String?
    var image: UIImage?
    var didSelectTextField: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.register(AmountTableViewCell.self, forCellReuseIdentifier: "AmountCell")
        tableView.register(ReceiptImageTableViewCell.self, forCellReuseIdentifier: "ReceiptImageCell")
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: "DatePickerCell")
        tableView.register(PickerTableViewCell.self, forCellReuseIdentifier: "PickerCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
        tableView.allowsMultipleSelection = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
      
        values[.date] = Date()
        values[.receiptImage] = image
        values[.walletAddress] = UserDefaults.standard.string(forKey: "DefaultAddress") ?? "0x2B4fa9A2064e8e0420dFF2B8d6c1D50a9C436966"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = types[indexPath.row]
        switch type {
        case .receiptImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptImageCell", for: indexPath) as! ReceiptImageTableViewCell
            cell.imageView?.image = values[type] as? UIImage
            cell.selectionStyle = .none
            return cell
        case .amount:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmountCell", for: indexPath) as! AmountTableViewCell
            let image = UIImage(systemName: "dollarsign.circle")
            cell.accessoryView = UIImageView(image: image)
            cell.accessoryView?.tintColor = Branding.Color.yellow
            if types.contains(.datePicker) || types.contains(.picker) {
                cell.textField.isEnabled = false
            } else if didSelectTextField  {
                
                cell.textField.isEnabled = true
                cell.textField.becomeFirstResponder()
            }
            cell.getAmount = {
                [weak self]
                amount in
                
                guard let amount = amount, let value = Double(amount) else {
                    return
                }
                
                self?.values[.amount] = value
                
            }
            
            return cell
        case .submitButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonTableViewCell
            cell.button.addTarget(self, action: #selector(submitReceipt), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case .datePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! DatePickerTableViewCell
            cell.initialDate = values[.date] as? Date
            cell.getDate = {
                [weak self]
                selectedDate in
                self?.values[.date] = selectedDate
                self?.tableView.reloadData()
            }
            return cell
        case .picker:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerTableViewCell
            cell.values = locations?.map { location in return location.name}
            cell.pickerView.reloadAllComponents()
            cell.getValue = {
                [weak self]
                selectedValue in
                
                self?.values[.location] = selectedValue
                self?.tableView.reloadData()
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
            var systemImage: String
            var value = values[type]
            switch type {
            case .date:
                systemImage = "calendar.circle"
                let date = value as! Date
                value = convert(date)
                
            case .location:
                systemImage = "location.circle"
                if let index = values[.location] as? Int {
                    value = locations![index].name
                }

            case .walletAddress:
                systemImage = "coloncurrencysign.circle"
                cell.selectionStyle = .none
            default:
                systemImage = ""
                break
            }
            cell.textLabel?.text = value as? String
            cell.textLabel?.textColor = Branding.Color.yellow
            cell.textLabel?.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
            
            if let image = UIImage(systemName: systemImage) {
                let imageView = UIImageView(image: image)
                imageView.preferredSymbolConfiguration = .init(scale: .large)
                cell.accessoryView = imageView
                cell.accessoryView?.tintColor = Branding.Color.yellow
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if types[indexPath.row] == .submitButton {
            cell.separatorInset = UIEdgeInsets.zero
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = types[indexPath.row]
        
        switch type {
        case .receiptImage:
            return 219
        case .submitButton:
            return 110
        case .picker, .datePicker:
            return 150
        default:
            return 43
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = types[indexPath.row]
        didSelectTextField = false
        
        switch type {
        case .date:
            let index = types.firstIndex(of: .date)! + 1
            if types.contains(.datePicker) {
                removePicker(.datePicker)
                removePicker(.picker)
            } else {
                types.insert(.datePicker, at: index)
                removePicker(.picker)
            }
        case .location:
            let index = types.firstIndex(of: .location)! + 1
            if types.contains(.picker) {
                removePicker(.datePicker)
                removePicker(.picker)
            } else {
                types.insert(.picker, at: index)
                removePicker(.datePicker)
            }
        case .amount:
            removePicker(.datePicker)
            removePicker(.picker)
            didSelectTextField = true

        default:
            removePicker(.datePicker)
            removePicker(.picker)
            break
        }
        
        tableView.reloadData()
    }
    
    func removePicker(_ picker: CellType) {
        guard picker == .datePicker || picker == .picker else {
            return
        }
        
        self.types.removeAll {
            type in
            
            return type == picker
        }
    }
    
    func convert(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    
    @objc func submitReceipt() {
        let displayAlert: (String, String) -> () = {
            title, message in
            
            let alertController = AlertSystem.createAlert(title: title, message: message)
            self.present(alertController, animated: true, completion: nil)
        }
        guard let image = values[.receiptImage] as? UIImage else {
            displayAlert("No Image", "There was an error with the image")
            return
        }

        guard let date = values[.date] as? Date else {
             displayAlert("No Date", "No date supplied")
            return
        }

        guard let index = values[.location] as? Int, let location = locations?[index] else {
             displayAlert("No Location", "No Loaction was Selected")
            return
        }

        let locationID = location.id
        let categoryID = location.categoryID

        guard let amount = values[.amount] as? Double else {
             displayAlert("No Amount", "No Amount was given")
            return
        }

        guard let address = values[.walletAddress] as? String else {
             displayAlert("No Address", "No Address was supplied")
            return
        }
        
         var receipt: ReceiptSubmission = ReceiptSubmission()
         receipt.image = image.jpegData(compressionQuality: 0)
         receipt.date = date
         receipt.locationID = locationID
         receipt.categoryID = categoryID
         receipt.amount = amount
         receipt.walletAddress = address
         
         
        
//        var receipt: ReceiptSubmission = ReceiptSubmission()
//        receipt.image = UIImage(systemName: "xmark.circle")!.pngData()
//        receipt.date = Date()
//        receipt.locationID = "locationID"
//        receipt.categoryID = "categoryID"
//        receipt.amount = 1.0
//        receipt.walletAddress = "address"
        
        let loadingController = LoadingViewController()
        loadingController.task = {
            completion in
            
            Network.shared.submit(receipt, completion: completion)
        }
        present(loadingController, animated: true, completion: nil)
    }
}
