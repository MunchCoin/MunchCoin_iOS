//
//  File.swift
//  MunchCoin
//
//  Created by Developer on 12/15/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

class PromptController: UIViewController {
    
    var promptTitle: String? { return pTitle }
    var promptMessage: String? { return pMessage }
    var buttonPrompt: String? { return buttonP }
    var  promptAction: (()->())? { return pAction }
    
    private var pTitle: String?
    private var pMessage: String?
    private var buttonP: String?
    @objc private var pAction: (()->())?
    
    private var titleLabel: UILabel = UILabel()
    private var messageLabel: UILabel = UILabel()
    private var filterView: UIView = UIView()
    private var backgroundImageView: UIImageView = UIImageView()
    private var mainStackView: UIStackView = UIStackView()
    private var promptStackView: UIStackView = UIStackView()
    private var promptButton: Button = Button()
    
   
    init(title: String, message: String, prompt: String, action: @escaping (() -> ()), backgroundImage: UIImage? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        set(title: title)
        set(message: message)
        set(buttonPrompt: prompt)
        set(promptAction: action)
        configureViews()
        
        guard let image = backgroundImage else {
            return
        }
        
        set(backgroundImage: image)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureViews() {
        let color: UIColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(filterView)
        view.addSubview(mainStackView)
        
        view.backgroundColor = color
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        filterView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 32
        
        mainStackView.addArrangedSubview(promptStackView)
        mainStackView.addArrangedSubview(promptButton)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43).isActive = true
        
        promptStackView.axis = .vertical
        promptStackView.alignment = .center
        promptStackView.distribution = .fill
        promptStackView.spacing = 13
        
        promptStackView.addArrangedSubview(titleLabel)
        promptStackView.addArrangedSubview(messageLabel)
        
        titleLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 36)
        titleLabel.textColor = color
        
        messageLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 24)
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
    }
    
    func set(title: String) {
        pTitle = title
        titleLabel.text = title.uppercased()
    }
    
    func set(message: String){
        pMessage = message
        messageLabel.text = message
    }
    
    func set(buttonPrompt: String) {
        buttonP = buttonPrompt
        promptButton.setTitle(buttonPrompt, for: .normal)
    }
    
    func set(promptAction: @escaping ()->()) {
        pAction = promptAction
        promptButton.addTarget(self, action: #selector(getter: pAction), for: .touchUpInside)
    }
    
    func set(backgroundImage: UIImage) {
        backgroundImageView.image = backgroundImage
    }
    
}
