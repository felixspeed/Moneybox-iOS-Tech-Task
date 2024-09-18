import UIKit
import Networking

protocol AccountsStackDelegate: AnyObject {
    func accountTapped(withTag: Int)
}

class AccountsStack: UIStackView {
    
    var accounts: [ProductResponse]?
    var delegate: AccountsStackDelegate?
    
    convenience init(accounts: [ProductResponse], delegate: AccountsStackDelegate) {
        self.init()
        
        self.accounts = accounts
        self.delegate = delegate
        setupStack()
    }
    
    private let accountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Accounts"
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var divider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension AccountsStack {
    private func setupStack() {
        layer.cornerRadius = 16
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        axis = .vertical
        spacing = 30
        layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        isLayoutMarginsRelativeArrangement = true
        addArrangedSubview(accountsLabel)
        addArrangedSubview(divider)
    }
}

extension AccountsStack {
    private func setupAccountsStack() {
        if let accounts {
            for account in accounts {
                let accountButton = AccountButton(account: account)
                accountButton.addTarget(self, action: #selector(accountTapped), for: .touchUpInside)
                accountButton.translatesAutoresizingMaskIntoConstraints = false
                addArrangedSubview(accountButton)
            }
        }
    }
}

extension AccountsStack {
    private func clearStack() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension AccountsStack {
    @objc private func accountTapped(sender: UIButton) {
        delegate?.accountTapped(withTag: sender.tag)
    }
}

extension AccountsStack {
    func displayAccounts(_ accounts: [ProductResponse]) {
        self.accounts = accounts
        clearStack()
        setupStack()
        setupAccountsStack()
    }
}
