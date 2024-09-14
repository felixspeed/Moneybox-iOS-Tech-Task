import UIKit

class HomeViewController: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        
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
}

extension HomeViewController {
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
