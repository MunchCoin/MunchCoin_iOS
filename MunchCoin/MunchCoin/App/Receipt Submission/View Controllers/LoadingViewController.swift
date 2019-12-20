//
//  LoadingViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/19/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    private var filterView:UIView = UIView()
    private var loadingView: UIView = UIView()
    private var mainStackView: UIStackView = UIStackView()
    private var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var button: Button = Button(style: .light)
    private var imageView: UIImageView = UIImageView()
    private var statusLabel: UILabel = UILabel()
    private var errorLabel: UILabel = UILabel()
   var task: ((@escaping (Bool, Error?) -> ()) -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
        configureViews()
        task(completion(isCompleted:error:))
    }
    
    @objc private func dismissLoading() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func runTask() {
        resetUI()
        task(completion(isCompleted:error:))
    }
    
    private func completion(isCompleted: Bool, error: Error?) {
        defer {
            updateUI(status: isCompleted)
        }
        
        guard let error = error else {
            errorLabel.text = nil
            button.addTarget(self, action: #selector(dismissLoading), for: .touchUpInside)
            return
        }
        
        errorLabel.text = error.localizedDescription
        button.addTarget(self, action: #selector(runTask), for: .touchUpInside)
    }
    
    private func resetUI() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        errorLabel.text = nil
        statusLabel.text = "LOADING"
        statusLabel.textColor = .white
        button.isEnabled = false
        button.setTitle("...", for: .normal)
        imageView.image = nil
        imageView.isHidden = true
        mainStackView.insertArrangedSubview(loadingIndicator, at: 1)
        
    }
    
    private func updateUI(status: Bool) {
        loadingIndicator.stopAnimating()
        button.isEnabled = true
        statusLabel.text = status ? "COMPLETE" : "ERROR"
        let color: UIColor = status ? .systemGreen : .systemRed
        statusLabel.textColor = color
        let title = status ? "Done" : "Try Again"
        button.setTitle(title, for: .normal)
        let image = status ? "checkmark" : "xmark"
        imageView.image = UIImage(named: image)
        imageView.tintColor = color
        imageView.isHidden = false
        loadingIndicator.removeFromSuperview()
        
    }
    
    private func configureViews() {
//        view.addSubview(filterView)
//        filterView.translatesAutoresizingMaskIntoConstraints = false
//        filterView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        filterView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.heightAnchor.constraint(equalToConstant: 211).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 211).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loadingView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: -16).isActive = true
        button.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        button.isEnabled = false
        button.setTitle("...", for: .normal)
        loadingView.backgroundColor = Branding.Color.yellow
        loadingView.layer.cornerRadius = 8
        
        loadingView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 32).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16).isActive = true
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 8
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(loadingIndicator)
        mainStackView.addArrangedSubview(statusLabel)
        mainStackView.addArrangedSubview(errorLabel)
        
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.color = .black
    
        statusLabel.font = UIFont(name: Branding.Font.berlinDemi, size: 24)
        statusLabel.text = "LOADING"
        
        errorLabel.font = UIFont(name: Branding.Font.berlinRegular, size: 12)
        errorLabel.isHidden = true
        
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.isHidden = true
    }
}
