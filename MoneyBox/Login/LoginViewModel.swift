import UIKit
import Networking

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
        #if DEBUG
        let email: String? = "test+ios@moneyboxapp.com"
        let pass: String? = "P455word12"
        #endif
        
        guard let email, let pass else { return }
        
        // TODO: Verify email is valid
        
        
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
    
    func loginSuccessful(response: LoginResponse) {
        // TODO: Store token, coordinator.finish()
        print("login success")
        coordinator?.finish()
    }
    
}
