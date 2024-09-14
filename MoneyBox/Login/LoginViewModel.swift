import UIKit
import Networking

protocol LoginViewModelDelegate {
    
}

class LoginViewModel {
    
    var coordinator: Coordinator?
    var delegate: LoginViewModelDelegate?
    
    private var dataProvider: DataProviderLogic
    
    init() {
        self.dataProvider = DataProvider()
    }
    
    func auth(email: String?, pass: String?) {
        guard let email, let pass else { return }
        
        // TODO: Verify email is valid
        
        
        #if DEBUG
        print("test")
        #endif
        
        let request = LoginRequest(email: email, password: pass)
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let success):
                // TODO: Store token, coordinator.finish()
                print("Login successful")
            case .failure(let failure):
                // TODO: Handle error and display to user through delegate
                print("Login failed")
            }
        }
    }
    
}
