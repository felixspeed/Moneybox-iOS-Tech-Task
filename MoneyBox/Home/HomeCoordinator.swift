import UIKit

protocol HomeCoordinatorDelegate {
    func delegateFinish(_ coordinator: HomeCoordinator)
}

class HomeCoordinator: Coordinator {
    
    var delegate: HomeCoordinatorDelegate?
    
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
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
