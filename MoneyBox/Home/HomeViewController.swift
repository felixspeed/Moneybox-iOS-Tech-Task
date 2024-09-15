import UIKit

class HomeViewController: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        
        setupNavBar()
        setupView()
        setupLayout()
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .blue
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.backgroundColor = .red
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    lazy private var logoutButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: UIImage(systemName: "person.slash"),
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }()
    
    private var logo: UIImageView = {
        let image = UIImage(named: "moneybox")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var test: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension HomeViewController {
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
                self.homeViewModel?.logout()
            }
        ))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController {
    func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accent as Any]
        appearance.backgroundColor = .primaryBackground
        navigationItem.standardAppearance = appearance
        navigationItem.title = homeViewModel?.greetingTitle
        navigationItem.leftBarButtonItem = logoutButton
    }
}

extension HomeViewController {
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(logo)
        view.addSubview(test)
    }
}

extension HomeViewController {
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
            
            logo.topAnchor.constraint(equalTo: contentView.topAnchor),
            logo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 300),
            logo.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            test.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 300),
            test.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            test.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            test.heightAnchor.constraint(equalToConstant: 300),
            test.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
}
