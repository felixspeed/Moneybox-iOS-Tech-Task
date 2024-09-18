import UIKit

enum LoginTextFieldType: Int {
    case email
    case pass
    
    var isSecure: Bool {
        switch self {
        case .email:
            false
        case .pass:
            true
        }
    }
    
    var returnType: UIReturnKeyType {
        switch self {
        case .email:
            .next
        case .pass:
            .done
        }
    }
}
