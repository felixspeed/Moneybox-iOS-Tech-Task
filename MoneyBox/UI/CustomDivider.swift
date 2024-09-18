import UIKit

class CustomDivider: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDivider()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDivider()
    }
    
    private func setupDivider() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
