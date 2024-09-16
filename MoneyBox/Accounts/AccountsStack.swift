import UIKit
import Networking

class AccountsStack: UIStackView {
    
    var accounts: [ProductResponse]?
    var accountLabels: [UILabel]?
    
    convenience init(accounts: [ProductResponse]) {
        self.init()
        
        self.accounts = accounts
        setupStack()
    }
    
    private let accountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Accounts"
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension AccountsStack {
    private func setupStack() {
        layer.backgroundColor = UIColor.primaryBackground?.cgColor
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
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(accountsLabel)
    }
}

extension AccountsStack {
    func setupAccountsStack() {
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
    @objc func accountTapped(sender: UIButton) {
        print(sender.tag)
    }
}

extension AccountsStack {
    func displayAccounts(_ accounts: [ProductResponse]) {
        self.accounts = accounts
        setupAccountsStack()
    }
}
