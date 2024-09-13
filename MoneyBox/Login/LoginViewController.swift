//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupView()
        setupLayout()
    }
    
    private let logoView: UIImageView = {
        let logo = UIImage(named: "moneybox")
        let view = UIImageView(image: logo)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email address"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: LoginTextField = {
        let field = LoginTextField()
        field.setupTextField(isPassword: false)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passTextField: LoginTextField = {
        let field = LoginTextField()
        field.setupTextField(isPassword: true)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
}

extension LoginViewController {
    func setupView() {
        view.addSubview(logoView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passLabel)
        view.addSubview(passTextField)
    }
}

extension LoginViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50),
            emailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            
            passLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.topAnchor.constraint(equalTo: passLabel.bottomAnchor, constant: 20),
            passTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
    }
}


