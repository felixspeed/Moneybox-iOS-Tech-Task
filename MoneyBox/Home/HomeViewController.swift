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
    
    private var homeTitle: UILabel = {
        let label = UILabel()
        label.text = "Test Home"
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var logoutButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: UIImage(systemName: "person.slash"),
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
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
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    func setupView() {
        view.addSubview(homeTitle)
    }
}

extension HomeViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            homeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}
