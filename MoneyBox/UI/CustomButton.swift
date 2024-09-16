import UIKit

class CustomButton: UIButton {
    var style: ButtonStyle?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, style: ButtonStyle) {
        self.init()
        
        self.style = style
        setupButton(title: title)
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let original = super.intrinsicContentSize
            return CGSize(width: original.width, height: original.height + 30)
        }
    }
    
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(style?.textColor, for: .normal)
        backgroundColor = style?.color
        layer.borderColor = style?.color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
}

enum ButtonStyle {
    case primary
    case secondary
    
    var color: UIColor {
        switch self {
        case .primary:
                .accent ?? .systemTeal
        case .secondary:
                .white
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .primary:
                .white
        case .secondary:
                .accent ?? .systemTeal
        }
    }
}
