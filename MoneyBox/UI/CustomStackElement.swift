import UIKit

class CustomStackElement: UIControl {
    
    // In general it's best to keep properties immutable (using `let` instead of `var`)
    // and with the lowest level of access control (i.e. `private` instead of `internal`,
    // which is the default if you don't specify anything
    //
    // private let primaryLeft: String?
    var primaryLeft: String?
    var secondaryLeft: String?
    var primaryRight: String?
    var secondaryRight: String?
    var isButton: Bool?
    
    convenience init(primaryLeft: String,
                     secondaryLeft: String? = nil,
                     primaryRight: String,
                     secondaryRight: String? = nil,
                     isButton: Bool,
                     id: Int? = nil) {
        self.init()
        self.primaryLeft = primaryLeft
        self.secondaryLeft = secondaryLeft
        self.primaryRight = primaryRight
        self.secondaryRight = secondaryRight
        self.isButton = isButton
        if let id {
            tag = id
        }
        
        setupLabels()
        setupLayout()
    }
    
    lazy private var primaryLeftLabel: UILabel = {
        let label = UILabel()
        label.text = self.primaryLeft
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var secondaryLeftLabel: UILabel = {
        let label = UILabel()
        label.text = self.secondaryLeft
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var primaryRightLabel: UILabel = {
        let label = UILabel()
        label.text = self.primaryRight
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var secondaryRightLabel: UILabel = {
        let label = UILabel()
        label.text = self.secondaryRight
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowIcon: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .accent
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupLabels() {
        addSubview(primaryLeftLabel)
        if secondaryLeft != nil {
            addSubview(secondaryLeftLabel)
        }
        addSubview(primaryRightLabel)
        if secondaryRight != nil {
            addSubview(secondaryRightLabel)
        }
        addSubview(arrowIcon)
        arrowIcon.isHidden = !(isButton ?? false)
    }
    
    private func setupLayout() {
        guard let isButton else { return }
        
        // Could you achieve the same layout with UIStackView?
        // If you can, it would be much better for readability and maintainability of the code
        
        NSLayoutConstraint.activate([
            // Fixed height elements are a nightmare, since users font could be any size. Try increasing
            // the font on your phone and take a look through the app :)
            self.heightAnchor.constraint(equalToConstant: 35),
            primaryLeftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        if secondaryLeft != nil {
            NSLayoutConstraint.activate([
                primaryLeftLabel.topAnchor.constraint(equalTo: topAnchor),
                secondaryLeftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                secondaryLeftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                primaryLeftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
        if secondaryRight != nil {
            NSLayoutConstraint.activate([
                primaryRightLabel.topAnchor.constraint(equalTo: topAnchor),
                secondaryRightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                primaryRightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
        
        if !isButton {
            NSLayoutConstraint.activate([
                primaryRightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
            if secondaryRight != nil {
                NSLayoutConstraint.activate([
                    secondaryRightLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
            }
        } else {
            NSLayoutConstraint.activate([
                arrowIcon.topAnchor.constraint(equalTo: topAnchor),
                arrowIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                arrowIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
                primaryRightLabel.trailingAnchor.constraint(equalTo: arrowIcon.leadingAnchor, constant: -8),
            ])
            if secondaryRight != nil {
                NSLayoutConstraint.activate([
                    secondaryRightLabel.trailingAnchor.constraint(equalTo: arrowIcon.leadingAnchor, constant: -8)
                ])
            }
        }
    }
    
    
}
