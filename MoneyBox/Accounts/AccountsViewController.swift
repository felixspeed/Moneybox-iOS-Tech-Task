import UIKit

protocol AccountsViewControllerDelegate: AnyObject {
    func loading(_ state: Bool)
    func updatePlanValueLabel(_ value: String)
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
       }
    #endif
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .primaryBackground
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
    
    lazy private var planValueLabel: UILabel = {
        let label = UILabel()
        label.text = accountsViewModel?.totalPlanValue
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        navigationItem.title = accountsViewModel?.greetingTitle
        navigationItem.leftBarButtonItem = logoutButton
    }
}

extension AccountsViewController {
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(planValueLabel)
        view.addSubview(spinnerView)
    }
}

extension AccountsViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            // Limit content view height anchor scroll views height anchor to allow scroll
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            planValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            planValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension AccountsViewController: AccountsViewControllerDelegate {
    func loading(_ state: Bool) {
        spinnerView.isHidden = state
        if state {
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }
    
    func updatePlanValueLabel(_ value: String) {
        planValueLabel.text = value
    }
    
    
}
