import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func loading(_ state: Bool)
    func addMoneyEnabled(_ state: Bool)
    func updateMoneyboxValue(_ value: String)
    func showError(_ error: String)
}

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
    
    private var addMoneyButton: CustomButton = {
        let button = CustomButton(title: "Add £10", style: .primary)
        button.addTarget(self, action: #selector(addMoneyButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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

extension DetailViewController {
    @objc private func addMoneyButtonTapped() {
        detailViewModel?.addMoney()
    }
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
        view.addSubview(addMoneyButton)
        view.addSubview(spinnerView)
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
            
            addMoneyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMoneyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addMoneyButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30),
            
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
}

extension DetailViewController: DetailViewControllerDelegate {
    func loading(_ state: Bool) {
        spinnerView.isHidden = !state
        if state {
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }
    
    func addMoneyEnabled(_ state: Bool) {
        addMoneyButton.isEnabled = state
    }
    
    func updateMoneyboxValue(_ value: String) {
        moneyboxLabel.text = value
    }
    
    func showError(_ error: String) {
        displayError(error)
    }
}

