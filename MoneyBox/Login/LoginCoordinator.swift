import UIKit

protocol LoginCoordinatorDelegate {
    func delegateFinish(_ coordinator: Coordinator)
}

class LoginCoordinator: Coordinator {
    
    var delegate: LoginCoordinatorDelegate?
    
    override func start() {
        displayLogin()
    }
    
    override func finish() {
        delegate?.delegateFinish(self)
    }
    
}

extension LoginCoordinator {
    private func displayLogin() {
        let loginViewController = LoginViewController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginViewController.loginViewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
