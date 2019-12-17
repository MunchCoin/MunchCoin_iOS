//
//  WalletSettingViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class WalletSettingViewController: UIViewController {
    var stackView: UIStackView = UIStackView()
    var promptStackView: UIStackView = UIStackView()
    var currentAddressLabel: UILabel = UILabel()
    var promptLabel: UILabel = UILabel()
    var addressTextField: UITextField = UITextField()
    var saveChangesButton: UIButton = UIButton()
    var removeButton: UIButton = UIButton()
    var addressStack: UIStackView = UIStackView()
    var feedbackGenerator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
    var addressStackContainer: UIView = UIView()
    var noAddressLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackGenerator.prepare()
        configureViews()
        
        if let address = UserDefaults.standard.string(forKey: "DefaultAddress") {
            addressTextField.text = address
            addAddress()
            
        } else {
            
            addressStack.removeFromSuperview()
            toggleNoAddressLabel(true)
        }
    }
    
    func configureViews() {
        view.addSubview(stackView)
        view.backgroundColor = Branding.Color.yellow
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resetViews))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        
        promptLabel.textColor = .black
        promptLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 24)
        promptLabel.text = "Enter Your Ethereum Wallet Address"
        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0
        
        currentAddressLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 12)
        currentAddressLabel.numberOfLines = 0
        currentAddressLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
        
        addressTextField.autocorrectionType = .no
        addressTextField.borderStyle = .line
        addressTextField.delegate = self
        addressTextField.clearsOnInsertion = true
        addressTextField.clearButtonMode = .always
        addressTextField.allowsEditingTextAttributes = true
        addressTextField.keyboardType = .asciiCapable
        
        noAddressLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 17)
        noAddressLabel.text = "No Address Saved"
        
        saveChangesButton.addTarget(self, action: #selector(saveValue), for: .touchUpInside)
        saveChangesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveChangesButton.widthAnchor.constraint(equalToConstant: 179).isActive = true
        saveChangesButton.layer.cornerRadius = 8
        saveChangesButton.backgroundColor = .white
        saveChangesButton.setTitleColor(.black, for: .normal)
        saveChangesButton.setTitle( "SAVE CHANGES", for: .normal)
        saveChangesButton.titleLabel?.font = UIFont(name: Branding.Font.berlinDemi, size: 17)
        
        promptStackView.addArrangedSubview(promptLabel)
        promptStackView.addArrangedSubview(currentAddressLabel)
        promptStackView.addArrangedSubview(addressTextField)
        
        
        
        stackView.addArrangedSubview(promptStackView)
        stackView.addArrangedSubview(saveChangesButton)
        
        
        promptStackView.axis = .vertical
        promptStackView.alignment = .center
        promptStackView.spacing = 8
        
        removeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        removeButton.setTitle(nil, for: .normal)
        removeButton.tintColor = .black
        removeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        removeButton.addTarget(self, action: #selector(removeAddress), for: .touchUpInside)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 36
        
        addressTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -64).isActive = true
        
        addressStackContainer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        addressStackContainer.layer.cornerRadius = 8
        addressStackContainer.addSubview(addressStack)
        stackView.insertArrangedSubview(addressStackContainer, at: 1)
        
        
        addressStack.axis = .horizontal
        addressStack.alignment = .center
        addressStack.distribution = .fillProportionally
        
        
        
        addressStack.addArrangedSubview(currentAddressLabel)
        addressStack.addArrangedSubview(removeButton)
        addressStack.translatesAutoresizingMaskIntoConstraints = false
        //        addressStack.heightAnchor.constraint(equalToConstant: 43).isActive = true
        addressStack.centerYAnchor.constraint(equalTo: addressStackContainer.centerYAnchor).isActive = true
        addressStack.leadingAnchor.constraint(equalTo: addressStackContainer.leadingAnchor, constant: 16).isActive = true
        addressStack.trailingAnchor.constraint(equalTo: addressStackContainer.trailingAnchor, constant: -16).isActive = true
        addressStackContainer.heightAnchor.constraint(equalToConstant: 75).isActive = true
        addressStackContainer.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -64).isActive = true
        
        
    }
    
    func check(_ address: String, completion: @escaping (Bool, (String, String)?) -> ()) {
        
        let balanceURL = "https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=\(EtherScanParams.contractAddress)&address=\(address)&tag=latest&apikey=\(EtherScanParams.apiKey)"
        guard let url = URL(string: balanceURL) else {
            completion(false, ("Address Error" , "Invalid Address"))

            return
        }
        Network.shared.getData(from: url) {
            data in
            
            guard let data = data else {
                print("No data was retrieved")
                completion(false, ("Internal Error", "No data was retrieved"))
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                print("Unable to deserialize data")
                completion(false, ("Internal Error", "Unable to deserialize data"))
                return
            }
            
            guard let result = json as? [String:String] else {
                print("Unable to convert json")
                completion(false, ("Internal Error","Unable to convert data" ))
                return
            }
            
            guard result["status"] == "1" else {
                print("API Error status: \(result["status"]!) message: \(result["result"]!)")
                completion(false, ("API Error" , "\(result["result"]!)"))
                return
            }
            
            print("Success")
            completion(true , nil)
            
        }
    }
    
    
    @objc func saveValue() {
        addressTextField.endEditing(true)
        
        guard let address = addressTextField.text else {
            print("No text available")
            return
        }
        
        
        save(address) {
            [weak self]
            addressSaved, error in
            
            guard addressSaved else {
                DispatchQueue.main.async {
                    self?.feedbackGenerator.notificationOccurred(.error)
                    self?.toggleState(false)
                    
                }
                
                DispatchQueue.main.async {
                    let alertController = AlertSystem.createAlert(title: error!.0, message: error!.1)
                    self?.present(alertController, animated: true, completion: nil)
                }
                return
            }
            DispatchQueue.main.async {
                self?.addAddress()
                self?.toggleState(true)
                self?.feedbackGenerator.notificationOccurred(.success)
            }
        }
    }
    
    func save(_ address: String, completion: ((Bool, (String, String)?) -> ())? = nil) {
        check(address){
            
            isValid, error in
            
            guard isValid else {
                
                print("Api error")
                completion?(false, error)
                return
            }
            
            print("Successful")
            UserDefaults.standard.set(address, forKey: "DefaultAddress")
            completion?(true, error)
        }
    }
    
    @objc func removeAddress() {
        UserDefaults.standard.removeObject(forKey: "DefaultAddress")
        currentAddressLabel.text = nil
        addressStack.removeFromSuperview()
        toggleNoAddressLabel(true)
        resetButton()
    }
    
    func addAddress() {
        var currentAddressString = "Default: "
        if let currentAddress = UserDefaults.standard.string(forKey: "DefaultAddress") {
            currentAddressString.append(contentsOf: currentAddress)
        }
        currentAddressLabel.text = currentAddressString
        toggleNoAddressLabel(false)
        addressStackContainer.addSubview(addressStack)
        addressStack.translatesAutoresizingMaskIntoConstraints = false
        //        addressStack.heightAnchor.constraint(equalToConstant: 43).isActive = true
        addressStack.centerYAnchor.constraint(equalTo: addressStackContainer.centerYAnchor).isActive = true
        addressStack.leadingAnchor.constraint(equalTo: addressStackContainer.leadingAnchor, constant: 16).isActive = true
        addressStack.trailingAnchor.constraint(equalTo: addressStackContainer.trailingAnchor, constant: -16).isActive = true
        
    }
    
    func toggleState(_ state: Bool) {
        saveChangesButton.setTitle(nil, for: .normal)
        let image = state ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")
        let color: UIColor = state ? .systemGreen : .systemRed
        saveChangesButton.setImage(image, for: .normal)
        saveChangesButton.tintColor = color
    }
    
    func resetButton() {
        saveChangesButton.setTitle("SAVE CHANGES", for: .normal)
        saveChangesButton.setImage(nil, for: .normal)
        saveChangesButton.tintColor = .black
    }
    
    @objc func resetViews() {
        addressTextField.endEditing(true)
        print("dfdsfs")
        resetButton()
    }
    
    func toggleNoAddressLabel(_ bool: Bool) {
        guard bool else {
            noAddressLabel.removeFromSuperview()
            return
        }
        addressStackContainer.addSubview(noAddressLabel)
        noAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        noAddressLabel.centerYAnchor.constraint(equalTo: addressStackContainer.centerYAnchor).isActive = true
        noAddressLabel.centerXAnchor.constraint(equalTo: addressStackContainer.centerXAnchor).isActive = true
        
    }
}


extension WalletSettingViewController: UIGestureRecognizerDelegate {
    
}
