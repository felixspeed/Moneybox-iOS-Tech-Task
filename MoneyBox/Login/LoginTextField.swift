import UIKit

class LoginTextField: UITextField {
    var type: LoginTextFieldType?
    
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
    
    func setupTextField(type: LoginTextFieldType) {
        tag = type.rawValue
        self.type = type
        backgroundColor = .primaryBackground
        isSecureTextEntry = type.isSecure
        returnKeyType = type.returnType
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
    
    func highlightBorder() {
        layer.borderColor = UIColor.accent?.cgColor
        layer.borderWidth = 2
    }
    
    func checkUnhighlightBorder() {
        if text?.isEmpty ?? false {
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 1
        }
    }
}
