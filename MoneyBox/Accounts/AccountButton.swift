import UIKit

class AccountButton: UIControl {
    
    var accountName: String?
    var value: Double?
    var moneybox: Double?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(accountName: String, value: Double, moneybox: Double) {
        self.init()
        
        self.accountName = accountName
        self.value = value
        self.moneybox = moneybox
        
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
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Right"
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupButton() {
        addSubview(leftLabel)
        addSubview(rightLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: topAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
