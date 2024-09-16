import UIKit
import Networking

class AccountButton: UIControl {
    
    var account: ProductResponse?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(account: ProductResponse) {
        self.init()
        
        guard let id = account.id else { return}
        self.account = account
        tag = id
        setupButton()
        setupLayout()
    }
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = self.account?.product?.name
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var idLabel: UILabel = {
        let label = UILabel()
        label.text = String(tag)
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Right"
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension AccountButton {
    private func setupButton() {
        addSubview(nameLabel)
        addSubview(idLabel)
        addSubview(rightLabel)
    }
}

extension AccountButton {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            idLabel.topAnchor.constraint(equalTo: topAnchor),
            idLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            idLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
