import UIKit
import Networking

class AccountButton: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(product: ProductResponse) {
        self.init()
        
        guard let id = product.id else { return}
        tag = id
        setupButton()
        setupLayout()
    }
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Left"
        label.textColor = .accent
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
        addSubview(leftLabel)
        addSubview(idLabel)
        addSubview(rightLabel)
    }
}

extension AccountButton {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: topAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            idLabel.topAnchor.constraint(equalTo: topAnchor),
            idLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            idLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
