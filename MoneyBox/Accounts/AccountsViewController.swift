import UIKit
import Networking

protocol AccountsViewControllerDelegate: AnyObject {
    func loading(_ state: Bool)
    func updatePlanValueLabel(_ value: String)
    func displayAccounts(_ accounts: [ProductResponse]?)
    func accountTapped(withTag: Int)
}

class AccountsViewController: UIViewController {
    
    var accountsViewModel: AccountsViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountsViewModel?.getAccounts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        
        #if DEBUG
        addDebugGestures()
        #endif
        
        setupNavBar()
        setupView()
        setupLayout()
    }
    
    #if DEBUG
    private func addDebugGestures() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(debugInfo))
           tapGesture.numberOfTapsRequired = 3
           view.addGestureRecognizer(tapGesture)
       }
       
       @objc private func debugInfo() {
           print(accountsViewModel?.totalPlanValue)
           print(accountsViewModel?.account?.accounts?.count)
           print(accountsViewModel?.account?.accounts?.first?.name)
           print(accountsViewModel?.account?.productResponses?.count)
           print(accountsViewModel?.account?.productResponses?.first?.product)
       }
    #endif
    
    private var scrollBackground: UIImageView = {
        let image = UIImage(named: "BackgroundAccent")
        let view = UIImageView(image: image)
        view.transform = view.transform.rotated(by: .pi / 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.backgroundColor = .primaryBackground
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    lazy private var logoutButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: UIImage(systemName: "person.slash.fill"),
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }()
    
    lazy private var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = accountsViewModel?.greetingTitle
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var planValueLabel: UILabel = {
        let label = UILabel()
        label.text = "£_.__"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var accountsStack: AccountsStack = {
        let stack = AccountsStack(accounts: [], delegate: self)
        return stack
    }()
    
    private let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .accent
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
}



extension AccountsViewController {
    @objc func logoutButtonTapped() {
        let alert = UIAlertController(
            title: "Are you sure you want to log out?",
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        alert.addAction(UIAlertAction(
            title: "Logout",
            style: .destructive,
            handler: { UIAlertAction in
                self.accountsViewModel?.logout()
            }
        ))
        self.present(alert, animated: true, completion: nil)
    }
}

extension AccountsViewController {
    func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accent as Any]
        appearance.backgroundColor = .primaryBackground
        navigationItem.standardAppearance = appearance
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = logoutButton
    }
}

extension AccountsViewController {
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollBackground)
        view.addSubview(greetingLabel)
        view.addSubview(planValueLabel)
        view.addSubview(accountsStack)
        view.addSubview(spinnerView)
    }
}

extension AccountsViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            // Limit content view height anchor scroll views height anchor to allow scroll
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            scrollBackground.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            scrollBackground.centerXAnchor.constraint(equalTo: view.trailingAnchor),
            scrollBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            scrollBackground.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            
            greetingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            planValueLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 20),
            planValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            accountsStack.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 30),
            accountsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            accountsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),

            
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension AccountsViewController: AccountsViewControllerDelegate {
    func loading(_ state: Bool) {
        spinnerView.isHidden = !state
        if state {
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }
    
    func updatePlanValueLabel(_ value: String) {
        planValueLabel.text = value
    }
    
    func displayAccounts(_ accounts: [ProductResponse]?) {
        if let accounts {
            accountsStack.displayAccounts(accounts)
        }
    }
}

extension AccountsViewController: AccountsStackDelegate {
    func accountTapped(withTag: Int) {
        accountsViewModel?.accountTapped(withTag: withTag)
    }
}
