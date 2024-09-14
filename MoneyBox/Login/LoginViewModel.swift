import UIKit
import Networking

protocol LoginViewModelDelegate {
    
}

class LoginViewModel {
    
    var coordinator: Coordinator?
    var delegate: LoginViewModelDelegate?
    
    func auth(email: String?, pass: String?) {
        guard let email, pass != nil else { return }
        
//        let request = LoginRequest(email: email, password: pass)
        
        
    }
    
}
