import UIKit

// I like your custom buttons and controls 👍
class CustomButton: UIButton {
    var style: ButtonStyle?
    
    override var isEnabled: Bool {
        didSet {
            layer.opacity = isEnabled ? 1 : 0.2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, style: ButtonStyle) {
        self.init(type: .system)
        
        self.style = style
        setupButton(title: title)
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let original = super.intrinsicContentSize
            return CGSize(width: original.width, height: original.height + 15)
        }
    }
    
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(style?.textColor, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        backgroundColor = style?.color
        layer.borderColor = style?.color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
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
