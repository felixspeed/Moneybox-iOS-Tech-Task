import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func loading(_ state: Bool)
    func addMoneyEnabled(_ state: Bool)
    func showError(_ error: String)
}

class DetailViewController: UIViewController {
    
    var detailViewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        
        setupNavBar()
        setupStack()
        setupView()
        setupLayout()
    }
    
    lazy private var valueLabel: UILabel = {
        let label = UILabel()
        label.text = detailViewModel?.product.planValue?.description.asCurrency
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var friendlyNameLabel: UILabel = {
        let label = UILabel()
        label.text = detailViewModel?.product.product?.friendlyName
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var infoStack: CustomStack = {
        let stack = CustomStack(title: nil,
                                areButtons: false,
                                delegate: nil)
        stack.backgroundColor = .primaryBackground
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy private var addMoneyButton: CustomButton = {
        let button = CustomButton(title: "Add £10", style: .primary)
        button.addTarget(self, action: #selector(addMoneyButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "Add money button"
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
        navigationItem.title = detailViewModel?.product.product?.name
    }
}

extension DetailViewController {
    private func setupStack() {
        guard let productInfo = detailViewModel?.getInfo() else { return }
        var productInfoViews: [CustomStackElement] = []
        for info in productInfo {
            productInfoViews.append(CustomStackElement(primaryLeft: info.label ?? "Unknown label",
                                                       secondaryLeft: info.subLabel,
                                                       primaryRight: info.info ?? "n/a",
                                                       secondaryRight: info.subInfo,
                                                       isButton: false
                                                      ))
        }
        infoStack.elements = productInfoViews
        infoStack.displayElements()
    }
}

extension DetailViewController {
    private func setupView() {
        view.addSubview(valueLabel)
        view.addSubview(friendlyNameLabel)
        view.addSubview(infoStack)
        view.addSubview(addMoneyButton)
        view.addSubview(spinnerView)
    }
}

extension DetailViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 85),
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            friendlyNameLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 10),
            friendlyNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoStack.topAnchor.constraint(equalTo: friendlyNameLabel.bottomAnchor, constant: 50),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
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
    
    func showError(_ error: String) {
        displayError(error)
    }
}

