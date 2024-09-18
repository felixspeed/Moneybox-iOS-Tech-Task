import UIKit

protocol CustomStackDelegate: AnyObject {
    func elementTapped(withTag: Int)
}

class CustomStack: UIStackView {
    
    var title: String?
    var buttons: [CustomStackElement] = []
    var elements: [CustomStackElement] = []
    var areButtons: Bool?
    var delegate: CustomStackDelegate?
    
    convenience init(title: String?, areButtons: Bool, delegate: CustomStackDelegate?) {
        self.init()
        
        self.title = title
        self.areButtons = areButtons
        self.delegate = delegate
        setupStack()
    }
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let divider: CustomDivider = {
        let div = CustomDivider()
        div.translatesAutoresizingMaskIntoConstraints = false
        return div
    }()
}

extension CustomStack {
    private func setupStack() {
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
        spacing = 40
        layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        isLayoutMarginsRelativeArrangement = true
        addArrangedSubview(titleLabel)
        setCustomSpacing(15, after: titleLabel)
        if title != nil {
            addArrangedSubview(divider)
        }
    }
}

extension CustomStack {
    private func setupElementsStack() {
        for element in elements {
            element.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(element)
        }
        for button in buttons {
            button.addTarget(self, action: #selector(elementTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(button)
        }
    }
}

extension CustomStack {
    private func clearStack() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension CustomStack {
    @objc private func elementTapped(sender: UIButton) {
        delegate?.elementTapped(withTag: sender.tag)
    }
}

extension CustomStack {
    func displayElements() {
        clearStack()
        setupStack()
        setupElementsStack()
    }
}
