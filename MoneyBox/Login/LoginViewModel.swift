import UIKit
import Networking
import Foundation

protocol LoginViewModelDelegate {
    
}

class LoginViewModel {
    
    var coordinator: LoginCoordinator?
    var delegate: LoginViewModelDelegate?
    
    private var dataProvider: DataProviderLogic
    
    init() {
        self.dataProvider = DataProvider()
    }
    
    func auth(email: String?, pass: String?) {
//        #if DEBUG
//        let email: String? = "test+ios@moneyboxapp.com"
//        let pass: String? = "P455word12"
//        #endif
        
        guard let email, let pass else { return }
        
        do {
            try validateEmail(email)
        } catch {
            // TODO: Handle error through delegate
            print("incorrect email")
            return
        }
        
        let request = LoginRequest(email: email, password: pass)
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let success):
                self.loginSuccessful(response: success)
            case .failure(let failure):
                // TODO: Handle error and display to user through delegate
                print("Login failed")
            }
        }
    }
    
    func validateEmail(_ email: String) throws {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard emailPredicate.evaluate(with: email) else {
            throw LoginError.validationError
        }
    }
    
    func loginSuccessful(response: LoginResponse) {
        // TODO: Store token
        coordinator?.finish()
    }
    
}


