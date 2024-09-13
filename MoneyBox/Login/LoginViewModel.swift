import UIKit

protocol LoginViewModelDelegate {
    
}

class LoginViewModel {
    
    var coordinator: Coordinator?
    var delegate: LoginViewModelDelegate?
    
    func auth(email: String, pass: String?) {
        
    }
    
}
