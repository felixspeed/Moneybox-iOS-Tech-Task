import UIKit

class LoginTextField: UITextField {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupTextField(isPassword: Bool) {
        backgroundColor = .primaryBackground
        isSecureTextEntry = isPassword
        returnKeyType = isPassword ? .done : .next
        layer.borderColor = UIColor.accent?.cgColor
        layer.borderWidth = 1
    }
}
