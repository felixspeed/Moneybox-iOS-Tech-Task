import UIKit

class LoginTextField: UITextField {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRectInset(bounds, 10, 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRectInset(bounds, 10, 10)
    }
    
    func setupTextField(isPassword: Bool) {
        /* 
        Explicitly defining the tag like this isn't ideal,
        ideally set up as an enum but functional for now
        */
        tag = isPassword ? 1 : 0
        backgroundColor = .primaryBackground
        isSecureTextEntry = isPassword
        returnKeyType = isPassword ? .done : .next
        layer.borderColor = UIColor.accent?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
}
