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
        view.backgroundColor = .primaryBackground
        
        setupView()
        setupLayout()
        configureTextFields()
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
    
    private let forgottenPassButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgotten password?", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // TODO: Make reusable for other stylised buttons
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.backgroundColor = .accent
        button.layer.cornerRadius = 8
        // TODO: Add logic for incorrectly populated fields
        button.layer.opacity = button.isEnabled ? 1.0 : 0.2
        
        
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension LoginViewController {
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, let pass = passTextField.text else { return }
        loginViewModel?.auth(email: email, pass: pass)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func configureTextFields() {
        emailTextField.delegate = self
        passTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc func screenTapped() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passTextField.becomeFirstResponder()
        case 1:
            passTextField.resignFirstResponder()
            loginButtonTapped()
        default:
            break
        }
        return false
    }
}

extension LoginViewController {
    func setupView() {
        view.addSubview(logoView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passLabel)
        view.addSubview(passTextField)
        view.addSubview(forgottenPassButton)
        view.addSubview(loginButton)
    }
}

extension LoginViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            
            emailLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            
            passLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.topAnchor.constraint(equalTo: passLabel.bottomAnchor, constant: 5),
            passTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            
            forgottenPassButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 5),
            forgottenPassButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30)
        ])
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
}


