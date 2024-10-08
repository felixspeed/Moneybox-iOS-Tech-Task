import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loading(_ state: Bool)
    func showError(_ error: String)
}

class LoginViewController: UIViewController {
    
    var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        view.accessibilityIdentifier = "Login"
        
        #if DEBUG
        addDebugGestures()
        #endif
        
        setupView()
        setupLayout()
        configureTextFields()
    }
    
    #if DEBUG
    private func addDebugGestures() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(debugLogin))
           tapGesture.numberOfTapsRequired = 5
           view.addGestureRecognizer(tapGesture)
       }
       
       @objc private func debugLogin() {
           let email: String? = "test+ios@moneyboxapp.com"
           let pass: String? = "P455word12"
           loginViewModel?.auth(email: email, pass: pass)
       }
    #endif
    
    private let logoView: UIImageView = {
        let logo = UIImage(named: "moneybox")
        let view = UIImageView(image: logo)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "Moneybox logo"
        return view
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email address"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: LoginTextField = {
        let field = LoginTextField()
        field.setupTextField(type: .email)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.accessibilityIdentifier = "Email login text field"
        return field
    }()
    
    private let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passTextField: LoginTextField = {
        let field = LoginTextField()
        field.setupTextField(type: .pass)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.accessibilityIdentifier = "Pass login text field"
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
    
    lazy private var loginButton: CustomButton = {
        let button = CustomButton(title: "Log in", style: .primary)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "Login button"
        return button
    }()
    
    private let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .accent
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
}

extension LoginViewController {
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, let pass = passTextField.text else { return }
        loginViewModel?.auth(email: email, pass: pass)
    }
}

extension LoginViewController: UITextFieldDelegate {
    private func configureTextFields() {
        emailTextField.delegate = self
        passTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func screenTapped() {
        view.endEditing(true)
        loginButton.isEnabled = fieldsPopulated()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passTextField.becomeFirstResponder()
            loginButton.isEnabled = fieldsPopulated()
        case 1:
            passTextField.resignFirstResponder()
            if fieldsPopulated() {
                loginButton.isEnabled = true
                loginButtonTapped()
            } else {
                loginButton.isEnabled = false
            }
        default:
            break
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let loginTextField = textField as? LoginTextField else { return }
        updateEditing(textField: loginTextField, withColor: .accent ?? .systemTeal, borderSize: 2)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let loginTextField = textField as? LoginTextField else { return }
        if loginTextField.text?.isEmpty ?? false {
            updateEditing(textField: loginTextField, withColor: .gray, borderSize: 1)
        }
    }
    
    func updateEditing(textField: LoginTextField, withColor: UIColor, borderSize: CGFloat) {
        textField.layer.borderColor = withColor.cgColor
        textField.layer.borderWidth = borderSize
        switch textField.type {
        case .email:
            emailLabel.textColor = withColor
        case .pass:
            passLabel.textColor = withColor
        case .none:
            return
        }
    }
    
    private func fieldsPopulated() -> Bool {
        guard let email = emailTextField.text, let pass = passTextField.text else { return false }
        return !email.isEmpty && !pass.isEmpty
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
        view.addSubview(spinnerView)
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
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension LoginViewController: LoginViewControllerDelegate{
    func loading(_ state: Bool) {
        spinnerView.isHidden = !state
        loginButton.isEnabled = !state
        if state {
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }
    
    func showError(_ error: String) {
        displayError(error)
    }
}
