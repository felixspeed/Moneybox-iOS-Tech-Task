import UIKit

class LoginCoordinator: Coordinator {
    override func start() {
        displayLogin()
    }
    
}

extension LoginCoordinator {
    private func displayLogin() {
        let loginViewController = LoginViewController()
        let loginViewModel = LoginViewModel()
        loginViewController.loginViewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
