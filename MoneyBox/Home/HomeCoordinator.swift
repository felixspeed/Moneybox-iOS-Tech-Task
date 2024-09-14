import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func delegateFinish(_ coordinator: HomeCoordinator)
}

class HomeCoordinator: Coordinator {
    
    
    private let navigationController: UINavigationController
    private var delegate: HomeCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: HomeCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    override func start() {
        displayHome()
    }
    
    override func finish() {
        delegate?.delegateFinish(self)
    }
    
}

extension HomeCoordinator {
    private func displayHome() {
        let homeViewController = HomeViewController()
        let homeViewModel = HomeViewModel()
        homeViewModel.coordinator = self
        homeViewController.homeViewModel = homeViewModel
        navigationController.viewControllers = [homeViewController]
    }
}
