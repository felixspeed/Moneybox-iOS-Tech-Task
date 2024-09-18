import UIKit

protocol CustomStackDelegate: AnyObject {
    func elementTapped(withTag: Int)
}

class CustomStack: UIStackView {
    
    var title: String?
    var buttons: [UIControl] = []
    var elements: [UIView] = []
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
    
    lazy private var divider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        spacing = 30
        layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        isLayoutMarginsRelativeArrangement = true
        if title != nil {
            addArrangedSubview(titleLabel)
        }
    }
}

extension CustomStack {
    private func setupElementsStack() {
        if areButtons ?? false {
            for button in buttons {
                addArrangedSubview(divider)
                button.addTarget(self, action: #selector(elementTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = false
                addArrangedSubview(button)
            }
        }
        for element in elements {
            addArrangedSubview(divider)
            element.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(element)
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
    func displayElements(_ elements: [UIView]) {
        self.elements = elements
        clearStack()
        setupStack()
        setupElementsStack()
    }
}
