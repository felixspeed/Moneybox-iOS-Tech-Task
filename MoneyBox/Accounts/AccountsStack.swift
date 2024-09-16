import UIKit
import Networking

class AccountsStack: UIStackView {
    
    var accounts: [Account]?
    var accountLabels: [UILabel]?
    
    convenience init(accounts: [Account]) {
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
        spacing = 8
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        isLayoutMarginsRelativeArrangement = true
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(accountsLabel)
    }
}

extension AccountsStack {
    func setupAccountsStack() {
        if let accounts {
            for account in accounts {
                let label = UILabel()
                label.text = account.name
                label.translatesAutoresizingMaskIntoConstraints = false
                addArrangedSubview(label)
            }
        }
    }
}

extension AccountsStack {
    func displayAccounts(_ accounts: [Account]) {
        self.accounts = accounts
        setupAccountsStack()
    }
}
