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
    
    lazy private var friendlyNameLabel: UILabel = {
        let label = UILabel()
        label.text = self.account?.product?.friendlyName
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var valueLabel: UILabel = {
        let label = UILabel()
        label.text = String(self.account?.planValue ?? 0.0).asCurrency
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowIcon: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

extension AccountButton {
    private func setupButton() {
        addSubview(nameLabel)
        addSubview(friendlyNameLabel)
        addSubview(valueLabel)
        addSubview(arrowIcon)
    }
}

extension AccountButton {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            friendlyNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            friendlyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            friendlyNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrowIcon.topAnchor.constraint(equalTo: topAnchor),
            arrowIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: arrowIcon.leadingAnchor, constant: -8),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
