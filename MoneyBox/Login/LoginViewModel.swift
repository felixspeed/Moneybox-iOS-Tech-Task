import UIKit
import Networking
import Foundation


class LoginViewModel {
    
    // There should be a single strong reference to a coordinator or delegate
    // hint: and it shouldn't be here :)
    var coordinator: LoginCoordinator?
    var viewDelegate: LoginViewControllerDelegate?
    
    private let dataProvider: DataProviderLogic
    private let tokenSessionManager: TokenSessionManager
    private let userModel: UserDefaultsHelper
    
    convenience init() {
        self.init(dataProvider: DataProvider(),
                  tokenSessionManager: TokenSessionManager.shared,
                  userModel: UserDefaults.standard)
        tokenSessionManager.delegate = self
    }
    
    init(dataProvider: DataProviderLogic, tokenSessionManager: TokenSessionManager, userModel:  UserDefaultsHelper) {
        self.dataProvider = dataProvider
        self.tokenSessionManager = tokenSessionManager
        self.userModel = userModel
    }
    
    func auth(email: String?, pass: String?) {
        guard let email, let pass else { return }
        
        do {
            try validateEmail(email)
        } catch {
            viewDelegate?.showError(LoginError.validationError.description)
            return
        }
        
        let request = LoginRequest(email: email, password: pass)
        viewDelegate?.loading(true)
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let success):
                self.loginSuccessful(response: success)
            case .failure(let failure):
                self.viewDelegate?.showError(failure.localizedDescription)
            }
            self.viewDelegate?.loading(false)
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
        tokenSessionManager.setUserToken(response.session.bearerToken)
        
        let user = response.user
        userModel.saveUser(user)
        
        coordinator?.finish()
    }
    
}

extension LoginViewModel: TokenSessionManagerDelegate {
    func logout() {
        coordinator?.logout()  
    }
}

