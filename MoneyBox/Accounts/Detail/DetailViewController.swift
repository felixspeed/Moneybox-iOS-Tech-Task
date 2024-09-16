import UIKit

class DetailViewController: UIViewController {
    
    var detailViewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        
        setupNavBar()
        setupView()
        setupLayout()
    }
    
    lazy private var valueLabel: UILabel = {
        let label = UILabel()
        label.text = detailViewModel?.account.planValue?.description.asCurrency
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var earningsLabel: UILabel = {
        let label = UILabel()
        label.text = "Current earnings: \(detailViewModel?.account.investorAccount?.earningsNet?.description.asCurrency ?? "n/a")"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var moneyboxLabel: UILabel = {
        let label = UILabel()
        label.text = "Moneybox: \(detailViewModel?.account.moneybox?.description.asCurrency ?? "n/a")"
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension DetailViewController {
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accent as Any]
        appearance.backgroundColor = .primaryBackground
        navigationItem.standardAppearance = appearance
        navigationItem.title = detailViewModel?.account.product?.name
    }
}

extension DetailViewController {
    private func setupView() {
        view.addSubview(valueLabel)
        view.addSubview(moneyboxLabel)
        view.addSubview(earningsLabel)
    }
}

extension DetailViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            earningsLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 15),
            earningsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            moneyboxLabel.topAnchor.constraint(equalTo: earningsLabel.bottomAnchor, constant: 30),
            moneyboxLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
}

