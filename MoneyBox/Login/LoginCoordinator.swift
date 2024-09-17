import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func delegateFinish(_ coordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private var delegate: LoginCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: LoginCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
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
        loginViewModel.viewDelegate = loginViewController
        loginViewController.loginViewModel = loginViewModel
        navigationController.viewControllers = [loginViewController]
    }
}
